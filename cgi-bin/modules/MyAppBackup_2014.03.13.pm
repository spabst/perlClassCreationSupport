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
		     'mode2' => 'view_form',
		     'mode3' => 'enregistrer_classe',
			 'mode4' => 'select_class',
			 'mode5' => 'delete_class',
			 'mode7' => 'instantiate_attribut',
			 'mode8' => 'instantiate_method',
			 'mode10' => 'liste_attributes',
			 'mode11' => 'delete_attribut',
			 'mode12' => 'show_attribut',
			 'mode13' => 'enregistrer_attribut',
			 'mode15' => 'delete_method',
			 'mode16' => 'show_method',
			 'mode17' => 'enregistrer_method',
			 'mode20' => 'ecrire_attribut',
			 'mode21' => 'parameters_clearing',
			 'mode22' => 'class_extension',
		     );
	 # $self->tmpl_path('../www/perlTemplates/');
    
######
   my @words = qw(vide);
   #$self->session->param( "existance_classe" => 0); 
   #$self->param( "default_classes_array_ref" => \@words);  
}

sub index {
    # Get CGI query object
    my $self = shift;
    my $q = $self->query();
    my $html_output = '';
    # Open the html template
    my $template = HTML::Template->new(filename => "../www/perlTemplates/index.tmpl.html", global_vars => 1);
    # parse the template
    $html_output .= $template->output;
    return $html_output;
}

### mode2 ###
sub view_form{
    # Get CGI query object
    my $self = shift;
    my $q = $self->query();
    my $nomprojetIndex = defined $q->param("nom_projet") ? $q->param("nom_projet") : $self->session->param("nom_projet");
	$self->session->param("nom_projet" => $nomprojetIndex);
	
	my @loop_noms = ();  # initialize an array to hold your loop
	my $classes = "nothing";
	if(defined $self->session->param( "existance_classe") ){
		my $ref_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
		my @noms_classes = keys % { $ref_noms_des_classes };

		while (@noms_classes) {
			my %row_data;  # get a fresh hash for the row data
			# fill in this row
			$row_data{WORD} = shift @noms_classes;
			# the crucial step - push a reference to this row into the loop!
			push(@loop_noms, \%row_data);
		}
		$classes = "something";		
	}

	my $error_message = defined $self->session->param("error_message") ? $self->session->param("error_message") : undef;
	$self->session->param("error_message" => undef);
	
	my $selected_class = defined $self->session->param("selected_class") ? $self->session->param("selected_class") : undef;

    my $html_output = '';
    my $template = HTML::Template->new(filename => '../www/perlTemplates/declarationClasses.tmpl.html');
    $template->param(
		     NOM_PROJET    => $nomprojetIndex,
		     THIS_LOOP => \@loop_noms,
			 ERROR_MESSAGE => $error_message,
			 CLASSES => $classes,
			 # TMPL_PATH => $self->tmpl_path(),
		     );
    $html_output .= $template->output;
    return $html_output;
}

###mode3###
sub enregistrer_classe{
    my $self = shift;
    my $q = $self->query();
	my $nouvelle_classe = $q->param("name");
	if ( valid_name($nouvelle_classe) eq "correct"){
		if (!(defined  $self->session->param("existance_classe") )){
			$self->session->param( "existance_classe" => 1);  
			my %ref_h_noms_des_classes = ( $nouvelle_classe => 1);
			
			$self->session->param( 'ref_h_noms_des_classes' => \%ref_h_noms_des_classes);
		}
		else{			
			my $ref_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
			my @keys =  keys % { $ref_noms_des_classes };
			my $arraysize = $#keys + 1;
			my %ref_h_noms_des_classes = %{$ref_noms_des_classes};
			$ref_h_noms_des_classes{$nouvelle_classe} = $arraysize + 1;
			#my %ref_h_noms_des_classes = ( $nouvelle_classe => 1, upupa => 2 , altro => 3);
			$self->session->param( 'ref_h_noms_des_classes' => \%ref_h_noms_des_classes);
		}
		my %h_attr_meth = ( "attributes" => "_nessuno_" , "methodes" => "_nessuno_", "parent" => undef );
		$self->session->param($nouvelle_classe => \%h_attr_meth);
		$self->session->param("error_message" => undef);
		$self->session->param("selected_class" => $nouvelle_classe);
	}
	else{
		$self->session->param("error_message" => valid_name($nouvelle_classe));
	}
	return $self->view_form();
}

###mode4###
sub select_class{
    my $self = shift;
    my $q = $self->query();
	my $selected_class = $q->param("selected_class");
	$self->session->param("selected_class" => $selected_class);
	return $self->liste_attributes();
}



###mode5###
sub delete_class{
	my $self = shift;
    my $q = $self->query();
	my $selected_class = $q->param("selected_class");
	$self->session->clear($selected_class);
	my $ref_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
	delete $$ref_noms_des_classes{$selected_class};
	if ($q->param("selected_class") eq $self->session->param("selected_class")){
		$self->session->param("selected_class" => undef);
	}
	return $self->view_form();
}

###mode7###
sub instantiate_attribut{
	my $self = shift;
    my $q = $self->query();
	my $nouvel_attr = $q->param("name");
	
	my $selected_class = $self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my $ref_h_attributs = $h_attr_meth{attributes};
	if ( valid_name($nouvel_attr) eq "correct"){
		if (!ref($ref_h_attributs)){
			my $default_att = Attribut->new(nom => $nouvel_attr,	ecriture => 1,	typeDeVar => 'Any', parent => 0);
			my %h_attributs = ($nouvel_attr => $default_att);
			$h_attr_meth{attributes} = \%h_attributs;
			$self->session->param($selected_class => \%h_attr_meth);
		}
		else{
			my $ref_h_attr_meth = $self->session->param($selected_class);
			my %h_attr_meth = %{$ref_h_attr_meth};
			my  $ref_h_attributs = $h_attr_meth{attributes};
			my $default_att = Attribut->new(nom => $nouvel_attr, ecriture => 1,	typeDeVar => 'Any');
			$$ref_h_attributs{$nouvel_attr} = $default_att;
			
			$self->session->param($selected_class => \%h_attr_meth);
		}
	}
	else{
		$self->session->param("error_message" => valid_name($nouvel_attr));
	}
	return $self->liste_attributes();
}

###mode8###
sub instantiate_method{
	my $self = shift;
    my $q = $self->query();
	my $nuovelle_methode = $q->param("name");
	
	my $selected_class = $self->session->param("selected_class");		
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my $ref_h_methodes = $h_attr_meth{methodes};
	if ( valid_name($nuovelle_methode) eq "correct"){
		if (!ref($ref_h_methodes)){
			###########################################
			my $script = "sticazzi";
			my %default_met = (name => $nuovelle_methode, script => $script );
			###################################################
			my %h_methods = ($nuovelle_methode => \%default_met);
			$h_attr_meth{methodes} = \%h_methods;
			$self->session->param($selected_class => \%h_attr_meth);
		}
		else{
			my $ref_h_attr_meth = $self->session->param($selected_class);
			my %h_attr_meth = %{$ref_h_attr_meth};
			my  $ref_h_methodes = $h_attr_meth{methodes};
			###########################################
			my $script = "proviamo, no?";
			my %default_met = (name => $nuovelle_methode, script => $script );
			###################################################
			$$ref_h_methodes{$nuovelle_methode} = \%default_met;
			
			$self->session->param($selected_class => \%h_attr_meth);
		}
	}
	else{
		$self->session->param("error_message" => valid_name($nuovelle_methode));
	}
	return $self->liste_attributes();
}


###mode10###
sub liste_attributes{
	my $self = shift;
	my $q = $self->query();
	my $selected_class =$self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	###### Attributs
	my  $ref_h_attributs = $h_attr_meth{attributes};
	my @loop_noms_attributs = (); 
	my $has_attributs;
	
	if (!ref($ref_h_attributs)){
		my $has_attributs = undef;
	}
	else{
		my $has_attributs = "vero";		
		my @noms_attributs = keys % { $ref_h_attributs };
		while (@noms_attributs) {
			my %row_data; 
			$row_data{WORD} = shift @noms_attributs;
			push(@loop_noms_attributs, \%row_data);
		}
	}
	###### Methodes
	my  $ref_h_methodes = $h_attr_meth{methodes};
	
	my $varDiProva;
	my @loop_noms_methodes = (); 
	my $has_methodes;
	
	if (!ref($ref_h_methodes)){
		my $has_methodes = undef;
		$varDiProva = "tentiamola";
	}
	else{
		my $has_methodes = "vero";		
		my @noms_methodes = keys % { $ref_h_methodes };
		while (@noms_methodes) {
			my %row_data; 
			$row_data{MET_NAME} = shift @noms_methodes;
			push(@loop_noms_methodes, \%row_data);
		}
		$varDiProva = "E speriamo che funzioni";
	}
	###### Parent property 
	my $parent = $h_attr_meth{parent} ?  $h_attr_meth{parent}: undef;
	my $ref_h_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
	
	
	#if (exists $ref_h_noms_des_classes{$parent}) {
	
	#}
	my @class_names = keys % { $ref_h_noms_des_classes };
	my @loop_class_names = ();
		while (@class_names) {
			my %row_data; 
			$row_data{CLASS_NAME} = shift @class_names;
			push(@loop_class_names, \%row_data);
	}

	######
	my $html_output = '';
    my $template = HTML::Template->new(filename => 'liste_attributes.tmpl.html');	
    $template->param(
		SELECTED_CLASS => $selected_class,
		PARENT => $parent,
		CLASS_NAMES_LOOP => \@loop_class_names,
		ATTRIBUTES_LOOP => \@loop_noms_attributs,
		METHODES_LOOP => \@loop_noms_methodes,
		STRINGA =>  $varDiProva,
		PROJECT_NAME => $self->session->param("nom_projet"),
	);
    $html_output .= $template->output;
    return $html_output;
}

###mode11###
sub delete_attribut{
	my $self = shift;
    my $q = $self->query();
	my $selected_class = $self->session->param("selected_class");
	
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my  $ref_h_attributs = $h_attr_meth{attributes};	
	
	my $selected_attribut = $q->param("selected_attribut");
	delete $$ref_h_attributs{$selected_attribut};
	
	$self->session->param($selected_class => \%h_attr_meth);
	return $self->liste_attributes();
}

###mode12###
sub show_attribut{
	my $self = shift;
	my $q = $self->query();
	my $selected_class =$self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my $ref_h_attributs = $h_attr_meth{attributes};
	my $selected_attribut = $q->param("selected_attribut");
	my %h_att = $$ref_h_attributs{$selected_attribut}->attr_hash();
	my @ref_arr_att = ();
	push(@ref_arr_att, \%h_att);
	my $html_output = '';
    my $template = HTML::Template->new(filename => 'modify_attributes.tmpl.html');
	$template->param(
		HACHAGE_LOOP => \@ref_arr_att,
		SELECTED_ATTRIBUT => $selected_attribut,
	);
	$html_output .= $template->output;
    return $html_output;
}



###mode13###
sub enregistrer_attribut{
	my $self = shift;
	my $q = $self->query();
	my $selected_class =$self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my $ref_h_attributs = $h_attr_meth{attributes};
	my $attribut_name = $q->param("attribut_name");
	
	my $selected_attribut = $q->param("selected_attribut");
	my $attr = Attribut->new(
		nom => 	$q->param("attribut_name"),
		ecriture =>  $q->param("access"),
		typeDeVar =>  $q->param("typeDeVar"),
		necessaire => $q->param("obligatoire"),	
		val_defaut =>  $q->param("valeur_defaut"),
		declencheur =>  $q->param("trigger"),
	); 
	delete $$ref_h_attributs{$selected_attribut};
	$$ref_h_attributs{$attribut_name} = $attr;	
	
	return $self->liste_attributes();
}
###mode15###
sub delete_method{
	my $self = shift;
    my $q = $self->query();
	my $selected_class = $self->session->param("selected_class");
	
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	my $ref_h_methods = $h_attr_meth{methodes};	
	
	my $selected_method = $q->param("selected_method");
	delete $$ref_h_methods{$selected_method};
	
	$self->session->param($selected_class => \%h_attr_meth);
	return $self->liste_attributes();
}
###mode16###
sub show_method{
	my $self = shift;
	my $q = $self->query();
	my $selected_class =$self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	
	
	my $ref_h_methods = $h_attr_meth{methodes};
	my $selected_method = $q->param("selected_method");
	
	my $ref_met = $$ref_h_methods{$selected_method};

	my $html_output = '';
    my $template = HTML::Template->new(filename => 'modify_method.tmpl.html');
	$template->param(
		SCRIPT => $$ref_met{script},
		SELECTED_METHOD => $selected_method,
	);
	$html_output .= $template->output;	
    return $html_output;
}

###mode17###
sub enregistrer_method{
	my $self = shift;
	my $q = $self->query();
	my $selected_class =$self->session->param("selected_class");
	my $ref_h_attr_meth = $self->session->param($selected_class);
	my %h_attr_meth = %{$ref_h_attr_meth};
	
	my $ref_h_methods = $h_attr_meth{methodes};
	my $method_name = $q->param("method_name");
	my $selected_method = $q->param("selected_method");
	my %met_definition = (
		name => 	$q->param("method_name"),
		script => 	$q->param("methods_content"),
	); 
	delete $$ref_h_methods{$selected_method};
	$$ref_h_methods{$method_name} = \%met_definition;	
	return $self->liste_attributes();
}




















###mode20###
sub ecrire_attribut{
    my $self = shift;
    my $q = $self->query();
	my $utilisateur = $self->session->param("_SESSION_ID");
	my $dirname ="temporaneo/" . $utilisateur;#. "/" . $self->session->param("nom_projet");
	mkdir("$dirname");
	$dirname = $dirname . "/" . $self->session->param("nom_projet");
	mkdir("$dirname");
	
	my $ref_h_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
	foreach my $class ( keys % { $ref_h_noms_des_classes }) {
	
		my $ref_h_attr_meth = $self->session->param($class);
		my %h_attr_meth = %{$ref_h_attr_meth};
		my $ref_h_attributs = $h_attr_meth{attributes};
		my $ref_h_methods = $h_attr_meth{methodes};
		my $parent = $h_attr_meth{parent} ? "use " . $h_attr_meth{parent}. ";\n\nextends " . $h_attr_meth{parent} .  ";" : "";
		
	
		my $filename = $dirname. "/" . $class . ".pm";
		open FILE, ">", $filename or die $!;
			print FILE	"package " . $class . ";\n" .
						"use Moose;\n" . 
						$parent .
						"\n\n" ,
						"###################################\n" .
						"#           ATTRIBUTES            #\n" . 
						"###################################\n" .
						"\n\n" ;
		close FILE;		
		

		if (ref($ref_h_attributs)){
			foreach my $attr (keys % { $ref_h_attributs }) {
				$$ref_h_attributs{$attr}->write_attr($filename);
			}
		}
		if (ref($ref_h_methods)){
			open FILE, ">>", $filename or die $!;
				print FILE	"\n\n" .
							"###################################\n" .
							"#            METHODS              #\n" .
							"###################################\n" .
							"\n\n" ;
				print FILE	"\n\nbanzai\n";
				foreach my $method (keys % { $ref_h_methods }) {
					my $ref_met = $$ref_h_methods{$method};
					print FILE	"sub " . $method . "{\n\t" .
								$$ref_met{'script'} .
								"\n}"
								;
				}
			close FILE;
		}
		
		open FILE, ">>", $filename or die $!;
			print FILE	"1;";
		close FILE;
	}
	
	$self->generate_zip();
	my $output = $self->download_zip();
	my $filename = "temporaneo/" . $self->session->param("nom_projet") . ".zip";
	unlink $filename;
	#return $self->forward("mode1");
	return $output;
}

###mode16###
sub generate_zip{
	my $self = shift;
    	my $q = $self->query();
	
	my $obj = Archive::Zip->new();   # new instance
					
	my $utilisateur = $self->session->param("_SESSION_ID");
	my $cartella ="temporaneo/" . $utilisateur . "/" . $self->session->param("nom_projet")."/";
	my $ref_h_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
	foreach my $file ( keys % { $ref_h_noms_des_classes }) {					
		$obj->addFile( $cartella . $file. ".pm");   # add files
	}

	#my $filezip = 'temporaneo/dummy.zip';
	my $filezip = "temporaneo/" . $self->session->param("nom_projet") . ".zip";
	if ($obj->writeToFileNamed($filezip) != AZ_OK) {  # write to disk
		print "Error in archive creation!";
	} else {
		print "Archive created successfully!";
		remove_tree( "temporaneo/" . $utilisateur);
	}
}

###mode21###
sub parameters_clearing{
    my $self = shift;
    $self->session_delete;
	return $self->index();
}








####################################################

sub valid_name{
	my $nom = $_[0];
	my $result;
	if($nom =~ m/^[a-z|A-Z|\_|\-][a-z|A-Z|\d|\_|\-|\.]+[a-z|A-Z|\d|\_]$/ ){
		$result = "correct";
	}
	elsif($nom !~ m/^[a-z|A-Z|\_|\-]/ ) {
		$result = '"Le nom doit commencer par une lettre (majuscule ou minuscule) ou bien par un underscore."';
	}
	elsif($nom !~ m/[a-z|A-Z|\d|\_|\-|\.]$/ ){
		$result = '"Le nom doit terminer par une lettre (majuscule ou minuscule) ou bien par un underscore, un chiffre ou un trait."';
	}	
	else{
		$result = '"Le nom inseré n\'est pas correct. Il ne peut contenir que des lettres (majuscules ou minuscules), des numéros, ou les signes suivants :\n\tunderscore (_)\n\tiret (-)\n\tpoint(.)\n"';
	}
	return $result;
}


sub download_zip{
my $self = shift;
	my $downloadfile = $self->session->param("nom_projet") . ".zip";
	my $fullpathdownloadfile = "temporaneo/$downloadfile";
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

####################################################################
####################################################################
sub moveup{
	my $self = shift;
    my $q = $self->query();
	
	
	
	
}
#=head
### mode22 ###
sub class_extension{
	my $self = shift;
    my $q = $self->query();	
	my $selected_class = $self->session->param("selected_class");
	my $ChildClass_ref_h_attr_meth = $self->session->param($selected_class);
	
	#my $parentname = $h_attr_meth{parent};
	$$ChildClass_ref_h_attr_meth{parent}=  $q->param("parent");
	
	
	#my $ref_h_noms_des_classes = $self->session->param( 'ref_h_noms_des_classes');
	#foreach my $class ( keys % { $ref_h_noms_des_classes }) {
	
		my $ParentClass_ref_h_attr_meth = $self->session->param($q->param("parent"));
		my %ParentClass_h_attr_meth = %{$ParentClass_ref_h_attr_meth};
		
		
		my $ParentClass_ref_h_attributs = $ParentClass_h_attr_meth{attributes};
		my $ChildClass_ref_h_attributs = $$ChildClass_ref_h_attr_meth{attributes};
	
	
	
	
		if (ref($ParentClass_ref_h_attributs)){
			foreach my $attr (keys % { $ParentClass_ref_h_attributs }) {
				$$ChildClass_ref_h_attributs{$attr} = $$ParentClass_ref_h_attributs{$attr};
				$$ChildClass_ref_h_attributs{$attr}->parent(1);
			}
		}
	
	
	
	
	
	
	
	return $self->liste_attributes();
}

#=cut

sub change_position(actual, destination){

}

1;