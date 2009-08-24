# XML::CAP::Info - class for XML::CAP <info> element classes
# Copyright 2009 by Ian Kluft
# This is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.
#
# parts derived from XML::Atom::Feed

package XML::CAP::Info;
use strict;
use warnings;
use base qw( XML::CAP::Base );
use XML::CAP;
use XML::CAP::Resource;
use XML::CAP::Area;

# inherits initialize() from XML::CAP::Base

sub element_name { 'info' }

# get list of <resource> elements
#sub resources
#{
#	my $self = shift;
#	my @res = $self->elem->getElementsByTagNameNS($self->ns, 'resource')
#		or return;
#	my @resources;
#	for my $res (@res) {
#		my $resource = XML::CAP::Info->new(Elem => $res->cloneNode(1));
#		push @resources, $resource;
#	}
#	@resources;
#}

# add an <resource> element
sub add_resources
{
	my $self = shift;
	my($resource, $opt) = @_;

	# note included from corresponding code in XML::Atom::Feed...
	# When doing an insert, we try to insert before the first <entry> so
	# that we don't screw up any preamble.  If there are no existing
	# <entry>'s, then fall back to appending, which should be
	# semantically identical.
	$opt ||= {};
	my ($first_entry) = $self->elem->getChildrenByTagNameNS($resource->ns,
		'resource');
	if ($opt->{mode} && $opt->{mode} eq 'insert' && $first_entry) {
		$self->elem->insertBefore($resource->elem, $first_entry);
	} else {
		$self->elem->appendChild($resource->elem);
	}
}

# get list of <area> elements
#sub areas
#{
#	my $self = shift;
#	my @res = $self->elem->getElementsByTagNameNS($self->ns, 'area')
#		or return;
#	my @areas;
#	for my $res (@res) {
#		my $area = XML::CAP::Info->new(Elem => $res->cloneNode(1));
#		push @areas, $area;
#	}
#	@areas;
#}

# add an <area> element
sub add_areas
{
	my $self = shift;
	my($area, $opt) = @_;

	# note included from corresponding code in XML::Atom::Feed...
	# When doing an insert, we try to insert before the first <entry> so
	# that we don't screw up any preamble.  If there are no existing
	# <entry>'s, then fall back to appending, which should be
	# semantically identical.
	$opt ||= {};
	my ($first_entry) = $self->elem->getChildrenByTagNameNS($area->ns,
		'area');
	if ($opt->{mode} && $opt->{mode} eq 'insert' && $first_entry) {
		$self->elem->insertBefore($area->elem, $first_entry);
	} else {
		$self->elem->appendChild($area->elem);
	}
}

# make accessors
__PACKAGE__->mk_elem_accessors(qw( language category event responseType urgency severity certainty audience eventCode effective onset expires senderName headline description instruction web contact parameter ));
__PACKAGE__->mk_object_list_accessor( 'resource' => 'XML::CAP::Resource',
	'resources' );
__PACKAGE__->mk_object_list_accessor( 'area' => 'XML::CAP::Area',
	'areas' );

1;
