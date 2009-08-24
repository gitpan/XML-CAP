# XML::CAP::Alert - class for XML::CAP alert element classes
# Copyright 2009 by Ian Kluft
# This is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.
#
# parts derived from XML::Atom::Feed

package XML::CAP::Alert;
use strict;
use warnings;
use base qw( XML::CAP::Base );
use XML::CAP;
use XML::CAP::Info;

=head1 NAME

XML::CAP::Alert - XML Common Alerting Protocol "alert" element class

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use XML::CAP;

    my $foo = XML::CAP->new();
    ...

=head1 FUNCTIONS

=cut

# inherits initialize() from XML::CAP::Base

sub element_name { 'alert' }

# get list of <info> elements
#sub infos
#{
#	my $self = shift;
#	my @res = $self->elem->getElementsByTagNameNS($self->ns, 'info')
#		or return;
#	my @infos;
#	for my $res (@res) {
#		my $info = XML::CAP::Info->new(Elem => $res->cloneNode(1));
#		push @infos, $info;
#	}
#	@infos;
#}

# add an <info> element
sub add_infos
{
	my $self = shift;
	my($info, $opt) = @_;

	# note included from corresponding code in XML::Atom::Feed...
	# When doing an insert, we try to insert before the first <entry> so
	# that we don't screw up any preamble.  If there are no existing
	# <entry>'s, then fall back to appending, which should be
	# semantically identical.
	$opt ||= {};
	my ($first_entry) = $self->elem->getChildrenByTagNameNS($info->ns,
		'info');
	if ($opt->{mode} && $opt->{mode} eq 'insert' && $first_entry) {
		$self->elem->insertBefore($info->elem, $first_entry);
	} else {
		$self->elem->appendChild($info->elem);
	}
}

# make accessors
__PACKAGE__->mk_elem_accessors(qw( identifier sender sent status msgType
	source scope restriction addresses code note references incidents ));
__PACKAGE__->mk_object_list_accessor( 'info' => 'XML::CAP::Info',
	'infos' );

1;
