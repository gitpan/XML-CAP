# XML::CAP::Parser - Parser class for XML::CAP
# Copyright 2009 by Ian Kluft
# This is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

package XML::CAP::Parser;
use strict;
use warnings;
use XML::CAP;
use base qw( XML::CAP );
use XML::CAP::Alert;
use XML::LibXML;

use Exception::Class (
	"XML::CAP::Parser::Exception::BadParameter" => {
		isa => "XML::CAP::Exception",
		alias => "throw_bad_param",
		description => "bad parameter to parser function",
	},
	"XML::CAP::Parser::Exception::ParserError" => {
		isa => "XML::CAP::Exception",
		alias => "throw_parser_error",
		description => "error returned from LibXML",
	},
);

# initialize function - initialize a new instance, called by XML::CAP::new
sub initialize
{
	my $self = shift;
	$self->{parser} = XML::LibXML->new();
	return $self;
}

# parse_file function - parse XML/CAP from a file
sub parse_file
{
	my $self = shift;
	my $filename = shift;
	
	if ( !defined $filename ) {
		throw_bad_param ("parse_file requires a filename paramater" );
	}

	eval_wrapper (
		sub { $self->{doc} = $self->{parser}->parse_file($filename)},
		\&throw_parser_error );
}

# parse_fh function - parse XML/CAP from a filehandle
sub parse_fh
{
	my $self = shift;
	my $fh = shift;
	
	if ( !defined $fh ) {
		throw_bad_param ("parse_fh requires a filehandle paramater" );
	}

	eval_wrapper (
		sub { $self->{doc} = $self->{parser}->parse_fh( $fh )},
		\&throw_parser_error );
}

# parse_string function - parse XML/CAP from a string
sub parse_string
{
	my $self = shift;
	my $string = shift;
	
	if ( !defined $string ) {
		throw_bad_param ( "parse_string requires a string paramater" );
	}

	eval_wrapper (
		sub { $self->{doc} = $self->{parser}->parse_string($string)},
		\&throw_parser_error );
}

# get the alert, the root of the CAP structure
sub alert
{
	my $self = shift;

	return XML::CAP::Alert->new(
		Elem => $self->{doc}->getDocumentElement->cloneNode(1));
}

# XPath query functions on the entire structure
# TODO: add them here

1;
