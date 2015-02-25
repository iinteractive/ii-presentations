package II::Presentations;

use strict;
use warnings;

use Data::Dump qw/dump/;
use JSON::XS ();
use Moose;
use Path::Class;

has 'json' => (is => 'ro', isa => 'JSON::XS', default => sub { JSON::XS->new->canonical->utf8; });

has 'data_dir' => (is => 'ro', isa => 'Str');

has 'author_dir' => (
    is => 'ro', 
    isa => 'Str', 
    lazy => 1,
    default => sub {
        (shift)->data_dir . '/authors' || die 'You must specify either a data_dir or an author_dir';
    }
);

has 'conference_dir' => (
    is => 'ro', 
    isa => 'Str', 
    lazy => 1,
    default => sub {
        (shift)->data_dir . '/conferences' || die 'You must specify either a data_dir or a conference_dir';
    }
);

has 'talks_dir' => (
    is => 'ro', 
    isa => 'Str', 
    lazy => 1,
    default => sub {
        (shift)->data_dir . '/talks' || die 'You must specify either a data_dir or a talks_dir';
    }
);

has 'authors' => (
    is => 'ro',
    isa => 'HashRef',
    lazy => 1,
    builder => '_build_authors'
);

has 'conferences' => (
    is => 'ro',
    isa => 'HashRef',
    lazy => 1,
    builder => '_build_conferences'
);

has 'classic_talks' => (
    is => 'ro',
    isa => 'HashRef',
    lazy => 1,
    builder => '_build_classic_talks'
);

has 'sorted_conferences' => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    lazy => 1,
    builder => '_build_sorted_conferences'
);

sub _build_authors {
    my $self = shift;
    my $authors;
    my $author_dir = Path::Class::Dir->new($self->author_dir);
    foreach my $author_file ($author_dir->children) {
        next unless -f $author_file;
        my $author_data = $author_file->slurp || die "Hit an unslurpable author: " . dump($author_file) . "";
        my $author = $self->json->decode($author_data) || die "Hit an unparseable author: " . dump($author_data) . "";
        $authors->{$author->{name}} = $author;
    }
    return $authors;
}

sub _build_conferences {
    my $self = shift;
    my $conferences;
    my $conference_dir = Path::Class::Dir->new($self->conference_dir);
    foreach my $conference_file ($conference_dir->children) {
        next unless -f $conference_file;
        my $conference_data = $conference_file->slurp || die "Hit an unslurpable conference: " . dump($conference_file) . "";
        my $conference = $self->json->decode($conference_data) || die "Hit an unparseable conference: " . dump($conference_data) . "";
        $conferences->{$conference->{name}} = $conference;		
    }
    return $conferences;
}

sub _build_classic_talks {
    my $self = shift;
    my $talks;
    my $talks_dir = Path::Class::Dir->new($self->talks_dir);
    foreach my $conference ($talks_dir->children) {
        next unless -d $conference;
        foreach my $year ($conference->children) {
            next unless -d $year;
            foreach my $talk_file ($year->children) {
                next unless -f $talk_file;
                my $talk_data = $talk_file->slurp || die "Hit an unslurpable talk: " . dump($talk_file) . "";
                my $talk = $self->json->decode($talk_data) || die "Hit an unparseable talk: " . dump($talk_data) . "";
                push @{$talks->{$talk->{conf}}->{$talk->{year}}}, $talk;
            }
        }
    }
    return $talks;
}

sub _build_sorted_conferences {
    my $self = shift;
    my @sorted;
    foreach my $key (sort { $self->conferences->{$a}->{sort_order} <=> $self->conferences->{$b}->{sort_order} } keys(%{$self->conferences})) {
        push @sorted, $key;
    }
    return \@sorted;
}

__PACKAGE__->meta->make_immutable;

1;
