package Attribut;
use Moose;

#use List::MoreUtils 'any';
#my $match_found = any { /pattern/ } @list_of_strings;

has nom => (
	is => 'ro', 
	isa => 'Str',
	required => 1,
	reader => 'obtenir_nom',
	#trigger => sub { $NbrPersonnes++; },
);

has ecriture => (
	is => 'rw', 
	isa => 'Bool',
	required => 1,
	reader   => 'obtenir_ecriture',
	default => 0,
);

has typeDeVar => (
	is => 'rw',
	isa => 'Str',
	required => 0,
	reader   => 'obtenir_typeDeVar',
	default => 'Any',
);
has necessaire => (
	is => 'rw',
	isa => 'Bool',
	required => 0,
	reader   => 'obtenir_necessite',
	default => 1,
);

has val_defaut => (
	is => 'rw',
	#isa => 'any',
	required => 0,
	reader   => 'obtenir_val_defaut',
);

has declencheur => (
	is => 'rw',
	isa => 'Str',
	required => 0,
	reader   => 'obtenir_declencheur',
);

has parent => (
	is => 'rw',
	isa => 'Bool',
	required => 1,
	reader   => 'obtenir_parent',
	#writer => 'set_parent',
	default => 0,
);

sub attr_hash{
	my $self = shift;
	my %elements_attribut  = (
		nom =>  $self->obtenir_nom,
		ecriture => $self->obtenir_ecriture,
		typeDeVar => $self->obtenir_typeDeVar,
		necessaire => $self->obtenir_necessite,
		val_defaut => $self->obtenir_val_defaut,
		declencheur => $self->obtenir_declencheur,
		parent =>  $self->obtenir_parent,
	);
	return %elements_attribut;
}

sub write_attr{
	my ($self, $fichier) = @_;
	my $tab = "    ";
	my $ecriture = defined  $self->obtenir_ecriture ? 'rw' : 'ro';
	my $val_defaut = defined  $self->obtenir_val_defaut ? $tab.sprintf("%-10s" ,"default")."=> " . $self->obtenir_val_defaut . ",\n": '';
	my $trigger = defined  $self->obtenir_declencheur ? $tab.sprintf("%-10s" ,"trigger") ."=> sub( " . $self->obtenir_declencheur . "),\n": '';
	
	open FILE, ">>", $fichier or die $!;
	print FILE 	"has " . $self->obtenir_nom . " => (\n" .
				$tab.sprintf("%-10s" ,"is") ."=> '" . $ecriture . "',\n".
				$tab.sprintf("%-10s" , "isa") . "=> '" . $self->obtenir_typeDeVar . "',\n" .
				$tab.sprintf("%-10s" ,  "required") ."=> " . $self->obtenir_necessite . ",\n" .
				$val_defaut .
				$trigger .
				"); \n\n" ;

	close FILE;
	return 1;
}


1;