#!C:/wamp/bin/perl/bin/perl.exe

BEGIN {
    $|  = 1;
    $^W = 1;
}

use strict;
use autodie;
use warnings;
use HTML::Template;

my $that_famous_string = 'Hello, world!';

my $tmpl = "<TMPL_VAR NAME=THAT_FAMOUS_STRING>\nMy Home Directory is <TMPL_VAR NAME=HOME>\n<br><br><br><br>My Path is set to <TMPL_VAR NAME=PATH>";

my $template = HTML::Template->new_scalar_ref(
    \$tmpl,
    strict => 1,
    debug  => 1,
);

$template->param(THAT_FAMOUS_STRING => $that_famous_string, HOME => $ENV{HOME} , PATH => $ENV{PATH} );
print "Content-Type: text/html\n\n"; 
print $template->output;