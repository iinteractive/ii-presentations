#!/usr/bin/env perl
use strict;
use warnings;
use Plack::Builder;

use Plack::Middleware::Static;
use Plack::Middleware::Xslate;

my $data = do 'conf/presentations.pl';

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
