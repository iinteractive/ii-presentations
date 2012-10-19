#!perl

use strict;
use warnings;

use Text::Xslate qw/ mark_raw /;

my $authors = {
    'Stevan Little' => {
        gravatar_url => 'http://www.gravatar.com/avatar/cc55e2ce28bd4649215ef05b8704e9be.png',
        github_url => 'https://github.com/stevan',
        cpan_url => 'https://www.metacpan.org/author/STEVAN',
    },
    'Yuval Kogman' => {
        gravatar_url => 'http://www.gravatar.com/avatar/965ab495ae19eeb538d054ae6caaf1bb.png',
        github_url => 'https://github.com/nothingmuch',
        cpan_url => 'https://www.metacpan.org/author/NUFFIN'
    },
    'Shawn Moore' => {
        gravatar_url => 'http://www.gravatar.com/avatar/609c52819f220e49667a53cc0a82bfa7.png',
        github_url => 'https://github.com/sartak',
        cpan_url => 'https://www.metacpan.org/author/SARTAK'
    },
    'Jesse Luehrs' => {
        gravatar_url => 'http://www.gravatar.com/avatar/88766de7a058697d3d0335b8d384fd2a.png',
        github_url => 'https://github.com/doy',
        cpan_url => 'https://www.metacpan.org/author/DOY'
    },
    'Jay Hannah' => {
        gravatar_url => 'http://www.gravatar.com/avatar/e45a33b946514b3720ca409b3b876f66.png',
        github_url => 'https://github.com/jhannah',
        cpan_url => 'https://www.metacpan.org/author/JHANNAH'
    },
    'John Anderson' => {
        gravatar_url => 'http://www.gravatar.com/avatar/025d30f04795e1efc142701e4ac89bfd.png',
        github_url => 'https://github.com/genehack',
        cpan_url => 'https://www.metacpan.org/author/GENEHACK'
    },
    'Dylan Hardison' => {
        gravatar_url => 'http://www.gravatar.com/avatar/ea4290f897444ad075f1c33fecc24f8f.png',
        github_url => 'https://github.com/dylanwh',
        cpan_url => 'https://www.metacpan.org/author/DHARDISON'
    }
};

my $talks = {
    'YAPC::NA' => {
        2006 => [
            {
                title => "Moose, it's the new Camel",
                author => 'Stevan Little'
            },
            {
                title => 'Compiling Perl 6',
                author => 'Yuval Kogman'
            }
        ],
        2008 => [
            {
                title => "Moose - A post modern object system for Perl 5",
                author => 'Stevan Little',
                schedule_url => 'http://conferences.mongueurs.net/yn2008/talk/1061',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/moose-a-post-modern-object-system-for-perl'
            },
            {
                title => "Horizontal Code Reuse with Moose::Role",
                author => 'Stevan Little',
                schedule_url => 'http://conferences.mongueurs.net/yn2008/talk/1063',
            }
        ],
        2009 => [
            {
                title => "KiokuDB - A Real World Introduction",
                author => 'Stevan Little',
                schedule_url => 'http://yapc10.org/yn2009/talk/1914',
            },
            {
                title => "To Moose or Not To Moose",
                author => 'Stevan Little',
                schedule_url => 'http://yapc10.org/yn2009/talk/1941',
            },
            {
                title => 'Extending Moose for Applications',
                author => 'Shawn Moore',
                schedule_url => 'http://yapc10.org/yn2009/talk/1880',
                slide_url => 'http://sartak.org/talks/yapc-na-2009/extending-moose/'
            },
            {
                title => 'What Haskell did to my brain',
                author => 'Yuval Kogman',
                schedule_url => 'http://yapc10.org/yn2009/talk/1956'
            },
            {
                title => 'Botting NetHack with TAEB',
                author => 'Jesse Luehrs',
                schedule_url => 'http://yapc10.org/yn2009/talk/2148',
            },
        ],
        2010 => [
            {
                title => 'Modern Perl (Tuesday Keynote)',
                author => 'Stevan Little',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2666',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/yapc-na-2010-tuesday-keynote',
                video_url => 'http://www.presentingperl.org/yn2010/modern-perl/'
            },
            {
                title => 'Intro to Moose',
                author => 'Stevan Little',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2720',
                video_url => 'http://www.presentingperl.org/yn2010/intro-to-moose/'
            },
            {
                title => 'Extending Moose',
                author => 'Jesse Luehrs',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2646',
                slide_url => 'http://tozt.net/talks/extending_moose_yapc_na_2010/'
            },
            {
                title => 'Hey! Path::Dispatcher kicks ass!',
                author => 'Shawn Moore',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2642',
                slide_url => 'http://sartak.org/talks/yapc-na-2010/path-dispatcher/'
            },
            {
                title => 'Catalyst in the wild: omnihotels.com',
                author => 'Jay Hannah',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2934',
            },
            {
                title => 'App::Termcast - share your terminals!',
                author => 'Jesse Luehrs',
                schedule_url => 'http://yapc2010.com/yn2010/talk/2647'
            }
        ],
        2011 => [
            {
                title => 'Jackalope',
                author => 'Stevan Little',
                schedule_url => 'http://www.yapc2011.us/yn2011/talk/3252'
            },
            {
                title => 'OX - The hardest working two letters in Perl',
                author => 'Jesse Luehrs',
                schedule_url => 'http://www.yapc2011.us/yn2011/talk/3251',
                slide_url => 'http://tozt.net/talks/ox_yapc_na_2011/'
            },
            {
                title => 'Announcing Announcements',
                author => 'Shawn Moore',
                schedule_url => 'http://www.yapc2011.us/yn2011/talk/3197',
                slide_url => 'http://sartak.org/talks/yapc-na-2011/announcing-announcements/'
            },
            {
                title => 'cpandoc',
                author => 'Shawn Moore',
                schedule_url => 'http://www.yapc2011.us/yn2011/talk/3519',
                slide_url => 'http://sartak.org/talks/yapc-na-2011/cpandoc/'
            },
            {
                title => 'All Your Code Gonna Git Got',
                author => 'John Anderson',
                schedule_url => 'http://www.yapc2011.us/yn2011/talk/3495',
                slide_url => 'http://sartak.org/talks/yapc-na-2011/cpandoc/'
            },
        ],
        2012 => [
            {
                title => 'Tweakers Anonymous',
                author => 'John Anderson',
                schedule_url => 'http://act.yapcna.org/2012/talk/127',
                video_url => 'http://www.youtube.com/watch?v=HVEDjLPZovA'
            },
            {
                title => 'Code Fast, Die Young, Throw Structured Exceptions',
                author => 'John Anderson',
                schedule_url => 'http://act.yapcna.org/2012/talk/126',
                video_url => 'http://www.youtube.com/watch?v=O1b-z7QvVW0'
            },
            {
                title => 'REST in the trenches - Jackalope part duex',
                author => 'Stevan Little',
                schedule_url => 'http://act.yapcna.org/2012/talk/35',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/rest-from-the-trenches'
            },
            {
                title => 'Dependency Injection with Bread::Board',
                author => 'Jesse Luehrs',
                schedule_url => 'http://act.yapcna.org/2012/talk/147',
                video_url => 'http://youtu.be/DhhaOQWoOpw',
                slide_url => 'http://tozt.net/talks/bread_board_yapc_na_2012/'
            },
            {
                title => 'git-status-tackle',
                author => 'Shawn Moore',
                schedule_url => 'http://act.yapcna.org/2012/talk/173',
                slide_url => 'http://sartak.org/talks/yapc-na-2012/git-status-tackle/'
            },
            {
                title => mark_raw('H&#299;D'),
                author => 'John Anderson',
                schedule_url => 'http://act.yapcna.org/2012/talk/168',
                slide_url => 'http://www.slideshare.net/genehackdotorg/hd-14787416',
            }
        ],
    },
    'YAPC::EU' => {
        2007 => [
            {
                title => 'Object Meta Programming',
                author => 'Yuval Kogman',
                schedule_url => 'http://vienna.yapceurope.org/ye2007/talk/662'
            },
            {
                title => 'Introduction to Moose',
                author => 'Stevan Little',
                schedule_url => 'http://vienna.yapceurope.org/ye2007/talk/648'
            }
        ],
        2012 => [
            {
                title => 'Moose Role Usage Patterns',
                author => 'Shawn Moore',
                schedule_url => 'http://act.yapc.eu/ye2012/talk/4150',
                slide_url => 'http://sartak.org/talks/yapc-eu-2012/role-usage-patterns/'
            },
            {
                title => 'TIMTOWTDI in 2012',
                author => 'Jesse Luehrs',
                schedule_url => 'http://act.yapc.eu/ye2012/talk/4182',
            },
            {
                title => 'Dependency Injection with Bread::Board',
                author => 'Jesse Luehrs',
                schedule_url => 'http://act.yapc.eu/ye2012/talk/4181',
                slide_url => 'http://tozt.net/talks/bread_board_yapc_eu_2012.pdf',
            },
            {
                title => 'A MOP for Perl 5',
                author => 'Stevan Little',
                schedule_url => 'http://act.yapc.eu/ye2012/talk/4069',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/perl-5-mop'
            }
        ],
    },
    'YAPC::Asia' => {
        2009 => [
            {
                title => 'API Design',
                author => 'Shawn Moore',
                schedule_url => 'http://conferences.yapcasia.org/ya2009/talk/2188',
                slide_url => 'http://sartak.org/talks/yapc-asia-2009/api-design/',
                video_url => 'http://www.nicovideo.jp/watch/sm8627720'
            },
            {
                title => '(Parameterized) Roles',
                author => 'Shawn Moore',
                schedule_url => 'http://conferences.yapcasia.org/ya2009/talk/2261',
                slide_url => 'http://sartak.org/talks/yapc-asia-2009/(parameterized)-roles/',
                video_url => 'http://www.nicovideo.jp/watch/sm8674742'
            },
        ],
        2010 => [
            {
                title => 'The Evolution of Path::Dispatcher',
                author => 'Shawn Moore',
                schedule_url => 'http://yapcasia.org/2010/talks/63D22246-BC8C-11DF-8791-B9FC0F276C45',
                slide_url => 'http://sartak.org/talks/yapc-asia-2010/evolution-of-path-dispatcher/',
                video_url => 'http://www.youtube.com/watch?v=fLVTZv4XjgM',
            },
        ],
        2011 => [
            {
                title => 'DTrace: printf debugging for seventh-level wizards',
                author => 'Shawn Moore',
                schedule_url => 'http://yapcasia.org/2011/talk/23.html',
                slide_url => 'http://sartak.org/talks/yapc-asia-2011/dtrace/',
                video_url => 'http://www.youtube.com/watch?v=GccTqjEWAp4'
            }
        ]
    },
    'OSCON' => {
        2008 => [
            {
                title => 'Moose: A Postmodern Object System for Perl 5',
                author => 'Stevan Little',
                schedule_url => 'http://www.oscon.com/oscon2008/public/schedule/detail/2469'
            }
        ],
    },
    'London Perl Workshop' => {
        2011 => [
            {
                title => 'A Brave New Perl World',
                author => 'Stevan Little',
                schedule_url => 'http://conferences.yapceurope.org/lpw2011/talk/3885',
                video_url => 'http://www.presentingperl.org/lpw2011/a-brave-new-perl-world/'
            }
        ]
    },
    'Pittsburgh Perl Workshop' => {
        2007 => [
            {
                title => 'Introduction to Moose',
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2007/talk/715'
            },
            {
                title => 'Horizontal Code Reuse with Moose::Role',
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2007/talk/714'
            }
        ],
        2008 => [
            {
                title => mark_raw( '<strike>R</strike>DBMs' ),
                author => 'Yuval Kogman',
                schedule_url => 'http://pghpw.org/ppw2008/talk/1543'
            },
            {
                title => 'Moose: A Postmodern Object System for Perl 5',
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2008/talk/1522'
            },
            {
                title => "The Case for switching to Python - A Manager's Guide to Moose",
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2008/talk/1523'
            },
            {
                title => 'Best Practices Are A PITA',
                author => 'John Anderson',
                schedule_url => 'http://pghpw.org/ppw2008/talk/1628'
            },
        ],
        2010 => [
            {
                title => 'The Evolution of Path::Dispatcher',
                author => 'Shawn Moore',
                schedule_url => 'http://pghpw.org/ppw2010/talk/3002',
                slide_url => 'http://sartak.org/talks/yapc-asia-2010/evolution-of-path-dispatcher/',
            },
            {
                title => 'Inversion of Control and Dependency Injection with Bread::Board',
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2010/talk/3030'
            },
            {
                title => 'Perl FitBit API',
                author => 'John Anderson',
                schedule_url => 'http://pghpw.org/ppw2010/talk/3081'
            }
        ],
        2011 => [
            {
                title => 'Perl and Git, Sitting In A Tree',
                author => 'John Anderson',
                schedule_url => 'http://pghpw.org/ppw2011/talk/3645'
            },
            {
                title => 'A Brave New Perl World',
                author => 'Stevan Little',
                schedule_url => 'http://pghpw.org/ppw2011/talk/3618'
            },
            {
                title => 'Examine Yr Moose',
                author => 'John Anderson',
                schedule_url => 'http://pghpw.org/ppw2011/talk/3879',
            },
        ],
    },
    'Orlando Perl Workshop' => {
        2009 => [
            {
                title => 'Objects in Lua',
                author => 'Dylan Hardison',
                schedule_url => 'http://www.perloasis.info/opw2009/talk/1703'
            }
        ],
        2010 => [
            {
                title => 'Untitled No. 12',
                author => 'Stevan Little',
                schedule_url => 'http://www.perloasis.info/opw2010/talk/2499',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/untitled-no-12',
                video_url => 'http://www.presentingperl.org/opw2010/untitled-no-12/'
            },
            {
                title => 'Surviving in the Cruel, Unforgiving World',
                author => 'Shawn Moore',
                schedule_url => 'http://www.perloasis.info/opw2010/talk/2476',
                video_url => 'http://www.presentingperl.org/opw2010/cruel-world/'
            },
            {
                title => 'How to Debianize a CPAN Dist',
                author => 'Dylan Hardison',
                schedule_url => 'http://www.perloasis.info/opw2010/talk/2483',
                video_url => 'http://www.presentingperl.org/opw2010/debianize/'
            }
        ],
        2011 => [
            {
                title => 'Managing assets: Keeping 7.5G of media files out of subversion',
                author => 'Dylan Hardison',
                schedule_url => 'http://www.perloasis.info/opw2011/talk/3181',
                video_url => 'http://www.presentingperl.org/opw2011/managing-assets/'
            },
            {
                title => 'Getting Code for Free - A Love Letter to Open Source (Keynote)',
                author => 'Stevan Little',
                schedule_url => 'http://www.perloasis.info/opw2011/talk/3182',
                video_url => 'http://www.presentingperl.org/opw2011/code-for-free/'
            },
            {
                title => 'Bicycle Commuting for the Telecommuter',
                author => 'Dylan Hardison',
                video_url => 'http://www.presentingperl.org/opw2011/bicycle-commuting-for-the-telecommuter/'
            }
        ],
        2012 => [
            {
                title => 'Organizing Technical Groups in Meatspace',
                author => 'Dylan Hardison',
                schedule_url => 'http://www.perloasis.info/opw2012/talk/3928',
                video_url => 'http://www.presentingperl.org/opw2012/organising-technical-groups-in-meatspace/'
            },
            {
                title => 'A Brave New Perl World',
                author => 'Stevan Little',
                schedule_url => 'http://www.perloasis.info/opw2012/talk/3966',
                video_url => 'http://www.presentingperl.org/opw2012/a-brave-new-perl-world/'
            },
            {
                title => 'DTrace: printf debugging for seventh-level wizards',
                author => 'Shawn Moore',
                schedule_url => 'http://www.perloasis.info/opw2012/talk/3868',
                slide_url => 'http://sartak.org/talks/perl-oasis-2012/dtrace/',
                video_url => 'http://www.presentingperl.org/opw2012/dtrace/'
            },
            {
                title => 'Life Fast Die Young',
                author => 'John Anderson',
                video_url => 'http://www.presentingperl.org/opw2012/life-fast-die-young/'
            },
            {
                title => 'Tweakers Anonymous',
                author => 'John Anderson',
                schedule_url => 'http://www.perloasis.info/opw2012/talk/3933',
                video_url => 'http://www.presentingperl.org/opw2012/tweakers-anonymous/'
            }
        ]
    },
    'Washington DC/Baltimore Perl Workshop' => {
        2012 => [
            {
                title => 'Future Perl (Keynote)',
                author => 'Stevan Little',
                schedule_url => 'http://dcbpw.org/dcbpw2012/talk/4081',
                slide_url => 'https://speakerdeck.com/u/stevan_little/p/dc-baltimore-perl-workshop-keynote'
            },
            {
                title => 'Introduction to Object Orientation',
                author => 'John Anderson',
                schedule_url => 'http://dcbpw.org/dcbpw2012/talk/4066'
            }
        ],
    },
    'Frozen Perl' => {
        2008 => [
            {
                title => 'Template::Declare',
                author => 'Shawn Moore',
                schedule_url => 'http://www.frozen-perl.org/mpw2008/talk/858',
                slide_url => 'http://sartak.org/talks/frozen-perl-2008/template-declare/frozen-perl.2008.txt'
            },
        ],
        2009 => [
            {
                title => 'Devel::REPL and Carp::REPL',
                author => 'Shawn Moore',
                schedule_url => 'http://www.frozen-perl.org/mpw2009/talk/1663',
                slide_url => 'http://sartak.org/talks/frozen-perl-2009/devel-repl/'
            },
            {
                title => 'Introduction to Moose',
                author => 'Shawn Moore',
                schedule_url => 'http://www.frozen-perl.org/mpw2009/talk/1687',
                slide_url => 'http://sartak.org/talks/frozen-perl-2009/moose/'
            },
        ],
    },
    'E-LAMP Nashville' => {
        2009 => [
            {
                title => 'Perl - Good Languages Borrow, Great Languages Steal',
                author => 'Stevan Little'
            }
        ],
    },
    'OSDC Taiwan' => {
        2010 => [
            {
                title => 'Nonhierarchical OOP',
                author => 'Shawn Moore',
                schedule_url => '',
                slide_url => 'http://sartak.org/talks/osdc.tw-2010/nonhierarchical-oop/'
            },
        ],
    },


};

{
  talks   => $talks,
  authors => $authors,
}
