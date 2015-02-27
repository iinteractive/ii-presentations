#!/usr/bin/env perl
use strict;
use warnings;
use Plack::Builder;

use Plack::Middleware::Static;
use Plack::Middleware::Xslate;

use II::Presentations;

my $presentations = II::Presentations->new({ data_dir => 'conf' });

my $authors = $presentations->authors;
my $conferences = $presentations->conferences;
my $sorted_conferences = $presentations->sorted_conferences;
my $talks = $presentations->talks;

my $data = {
    authors => $authors,
    conferences => $conferences,
    sorted_conferences => $sorted_conferences,
    talks => $talks
};

builder {
    enable sub {
        my $app = shift;
        sub {
            $_[0]->{PATH_INFO} =~ s/\/$/\/index.html/;
            $_[0]->{PATH_INFO} =~ s/\.html$/\.tx/;
            $app->($_[0])
        };
    };
    enable Xslate => (
        path         => qr{^/},
        root         => 'templates/',
        pass_through => 1,
        xslate_vars  => $data,
        xslate_args  => {
            function => {
                get_year => sub { (localtime)[5] + 1900 } ,
                to_ident => sub {
                    my $ident = lc $_[0];
                    $ident =~ s/\s/_/g;
                    $ident =~ s/\-/_/g;
                    $ident =~ s/\//_/g;
                    $ident =~ s/\:/_/g;
                    $ident;
                },
            },
        },
    );
    enable Static => (
        path         => qr{^/(?:css|js|img)\b},
        root         => './',
        pass_through => 1,
    );
    sub { [ 404, [], [ 'Not found' ] ] };
};
