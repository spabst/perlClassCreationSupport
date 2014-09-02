#!C:/wamp/bin/perl/bin/perl.exe -w

package MyApp;
use HTML::Template;
use strict;
use warnings;
use base 'CGI::Application';
use CGI::Application::Plugin::AutoRunmode;
use CGI::Application::Plugin::Config::Simple;
use CGI::Application::Plugin::DBH (qw/dbh_config dbh/);
use CGI::Application::Plugin::Session;
use CGI::Application::Plugin::Redirect;
use CGI::Application::Plugin::Forward;
use File::Path qw(make_path remove_tree);

use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use My::Attribut;
use Data::Dumper;


use JSON;
use JSON::PP;
use UNIVERSAL 'isa';

sub cgiapp_init {
	my $self = shift;
	$self->session_config(
	  CGI_SESSION_OPTIONS => [ "driver:File", $self->query, {Directory=>'tmp'} ],
	  COOKIE_PARAMS       => {
							   -path  => '/',
							   -expires => '+24h',
							 },
	  SEND_COOKIE         => 1,
	);
}

sub setup {
	my $self = shift;
	$self->start_mode('mode1');
	$self->session;
	$self->run_modes(
		'mode1' => 'index',
		# 'mode2' => 'view_form',
		'mode20' => 'ecrire_attribut',
		# 'mode21' => 'parameters_clearing',
		# 'mode22' => 'class_extension',
	);
	 # $self->tmpl_path('../www/perlTemplates/');
    
######
 
}

sub index {
    # Get CGI query object
    my $self = shift;
    my $q = $self->query();
    my $html_output = '';
    # Open the html template
    my $template = HTML::Template->new(filename => "../www/SebaPerlClas/index.html", global_vars => 1);
    # parse the template
    $html_output .= $template->output;
    return $html_output;
}

# ### mode2 ###
# sub view_form{
#     # Get CGI query object
#     my $self = shift;
#     my $q = $self->query();

#     my $nomeProgetto = defined $q->param("nomeProgetto") ? $q->param("nomeProgetto") : "cacca";
#     $self->session->param("nomeProgetto" => $nomeProgetto);

#     my $classesList = defined $q->param("classesList") ? $q->param("classesList") : "cacca";
#     $self->session->param("classesList" => $classesList);


#     # $self->session->param("classesList" => $classesList);
	
# 	my @loop_noms = ();  # initialize an array to hold your loop
# 	my $classes = "nothing";
# 	if(defined $self->session->param( "existance_classe") ){
# 		my $ref_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
# 		my @noms_classes = keys % { $ref_noms_des_classes };

# 		while (@noms_classes) {
# 			my %row_data;  # get a fresh hash for the row data
# 			# fill in this row
# 			$row_data{WORD} = shift @noms_classes;
# 			# the crucial step - push a reference to this row into the loop!
# 			push(@loop_noms, \%row_data);
# 		}
# 		$classes = "something";		
# 	}

# 	my $error_message = defined $self->session->param("error_message") ? $self->session->param("error_message") : undef;
# 	$self->session->param("error_message" => undef);
	
# 	my $selected_class = defined $self->session->param("selected_class") ? $self->session->param("selected_class") : undef;

#     my $html_output = '';
#     my $template = HTML::Template->new(filename => '../www/SebaPerlClas/declarationClasses.tmpl.html');
#     $template->param(
# 		#NOM_PROJET    => $nomprojetIndex,
# 		NOME_PROGETTO    => $nomeProgetto,
# 		     );
#     $html_output .= $template->output;
#     return $html_output;
# }









###mode20###
sub ecrire_attribut{
    my $self = shift;

	my $q = $self->query();

	my $nomeProgetto = defined $q->param("nomeProgetto") ? $q->param("nomeProgetto") : "undefined";
	$self->session->param("nomeProgetto" => $nomeProgetto);

	my $classesList = defined $q->param("classesList") ? $q->param("classesList") : "[]";
	$self->session->param("classesList" => $classesList);


	my $utilisateur = $self->session->param("_SESSION_ID");
	my $dirname ="temporaneo/" . $utilisateur;
	# my $dirname ="temporaneo/";
	mkdir("$dirname");
	$dirname = $dirname . "/" . $self->session->param("nomeProgetto");
	mkdir("$dirname");


	my $classelist = JSON->new->utf8->decode( $self->session->param("classesList") );

	
	foreach my $class ( @$classelist ) {
	

		$class->{'hasParent'} = $class->{'hasParent'} ? "use " . $class->{'hasParent'} . ";\n\nextends " . $class->{'hasParent'} . ";" : "";
	
		# The user's comments have to be adapted. 
		# We fist add a '#' at the beginning of the string (only if non-empty) to comment out the first line
		$class->{'comments'} = $class->{'comments'} ? "# " .$class->{'comments'} : "";
		#then we use regular expressions to replace the '<%class_name%>' expression with the current class name.
		$class->{'comments'} =~ s/<%class_name%>/$class->{'name'}/g;
		# At the end, we put a '#' at the beginning of every new line, to comment it out.
		$class->{'comments'} =~ s/\n/\n#  /g;
	
	
	 	my $filename = $dirname. "/" . $class->{'name'} . ".pm";
		open FILE, ">", $filename or die $!;

			#print FILE "Size: " . scalar @$classelist . "\n\n";

			#print FILE $self->session->param("classesList") . "\n\n";

			# if(ref( $classelist ) eq 'ARRAY') {
			# # my $json = JSON::PP->new;
			# #       $data = $json->decode(<$json_stream>);
			# 	print FILE "\n\nsi tratta di un Array!!!! Hai visto???\n";
			# }
			# else{
			# 	print FILE "NON SI tratta di un Array!!!! BIGOLO!\n\n\n";
			# }


	 		print FILE	"\npackage " . $class->{'name'} . ";\n" .
 					"use Moose;\n" . 
					$class->{'hasParent'} .
 					"\n\n" . $class->{'comments'} .
 					"\n\n" .
 					"###################################\n" .
 					"#           ATTRIBUTES            #\n" . 
 					"###################################\n" .
 					"\n" .
 					#"Size: " . scalar @{$class->{'attributes'}} . "\n" .

 					"\n";
 					my $tab = "    ";
 					foreach my $attribut ( @{$class->{'attributes'}}) {

 						$attribut->{'rw'} = $attribut->{'rw'} ? 'rw' : 'ro';
 						$attribut->{'defaultValue'} = $attribut->{'defaultValue'} ? $tab.sprintf("%-10s" ,"default")."=> " . $attribut->{'defaultValue'} . ",\n" : '';
 						$attribut->{'trigger'} = $attribut->{'trigger'} ? $tab.sprintf("%-10s" ,"trigger") ."=> sub( " . $attribut->{'trigger'} . "),\n" : '';


 						print FILE 	"has " .  $attribut->{'name'} . " => (\n" .
						$tab.sprintf("%-10s" ,"is") ."=> '" . $attribut->{'rw'} . "',\n".
			 			$tab.sprintf("%-10s" , "isa") . "=> '" . $attribut->{'VarType'} . "',\n" .
						$tab.sprintf("%-10s" ,  "required") ."=> " . $attribut->{'mandatory'} . ",\n" .
						$attribut->{'defaultValue'} .
						$attribut->{'trigger'} .
						"); \n\n" ;
 					}



			print FILE	"\n\n" .
					"###################################\n" .
					"#            METHODS              #\n" .
					"###################################\n" .
					"\n\n" ;


					foreach my $method ( @{$class->{'methods'}}) {
 						print FILE 	"sub " . $method->{'name'} . " {\n\t" .
								$method->{'defintition'} .
								"\n}\n\n";
 					}

		close FILE;

		
		open FILE, ">>", $filename or die $!;
			print FILE	"1;".
					"\n\nno Moose;" .
					"\n__PACKAGE__->meta->make_immutable;";
		close FILE;
	}
	
	$self->generate_zip();
	my $output = $self->download_zip();




	#my $filename = "temporaneo/" . $self->session->param("nom_projet") . ".zip";
	my $filename ="temporaneo/" . $self->session->param("_SESSION_ID") . "/" . $self->session->param("nomeProgetto"). ".zip";

	# my $filename = "temporaneo/dummy.zip";
	unlink $filename;
	
	remove_tree( "temporaneo/" . $utilisateur);
	return $output;
}

###mode16###
sub generate_zip{
	my $self = shift;
    	my $q = $self->query();
	
	my $obj = Archive::Zip->new();   # new instance
					
	my $utilisateur = $self->session->param("_SESSION_ID");
	my $cartella ="temporaneo/" . $utilisateur . "/" . $self->session->param("nomeProgetto")."/";


	my $classelist = JSON->new->utf8->decode( $self->session->param("classesList") );

	
	foreach my $class ( @$classelist ) {
		$obj->addFile( $cartella . $class->{'name'} . ".pm");   # add files
	}


	my $filezip = "temporaneo/"  . $utilisateur . "/" . $self->session->param("nomeProgetto") . ".zip";
	if ($obj->writeToFileNamed($filezip) != AZ_OK) {  # write to disk
		print "Error in archive creation!";
	} else {
		print "Archive created successfully!";
		remove_tree( "temporaneo/" . $utilisateur . "/" . $self->session->param("nomeProgetto") );
	}
}



sub download_zip{
	my $self = shift;

	my $utilisateur = $self->session->param("_SESSION_ID");
	my $downloadfile = $self->session->param("nomeProgetto") . ".zip";
	# my $downloadfile = $self->session->param("nom_projet") . ".zip";
	my $fullpathdownloadfile = "temporaneo/" . $utilisateur . "/" . "$downloadfile";

	# my $downloadfile = "dummy.zip";
	# my $fullpathdownloadfile = "temporaneo/dummy.zip";

	my $output = '';
	my $buffer = '';
	open my $fh, '<', $fullpathdownloadfile
	  or return error_handler("Error: Failed to download file <b>$downloadfile</b>:<br>$!<br>");

	while (my $bytesread = read($fh, $buffer, 1024)) {
	  $output .= $buffer;
	}

	close $fh
	  or return error_handler("Error: Failed to download file <b>$downloadfile<b>:<br>$!<br>");

	my  $downloadfilesize = (stat($fullpathdownloadfile))[7]
	  or return error_handler("Error: Failed to get file size for <b>$downloadfile<b>:<br>$!<br>");
	  
	$self->header_props(
						'-type'                => 'application/x-download',
						'-content-disposition' => "attachment;filename=$downloadfile",
						'-content_length'      => $downloadfilesize,
					   );
	return $output;
};


1;