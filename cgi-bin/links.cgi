#!C:/wamp/bin/perl/bin/perl.exe
##
##  CGI Application Hello World
##

use strict;
use lib 'modules';  # this is where I put MyApp.pm
use CGI::Carp qw(fatalsToBrowser);
use MyApp;

my $helloworld = MyApp->new('../www/perlTemplates/');
# tmpl_path => 'http://localhost/perlTemplates'
# MyApp::User->new(tmpl_path => '/path/to/templates/');
$helloworld->run();

