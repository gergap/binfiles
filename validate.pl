#!/usr/bin/env perl
use 5.020; use warnings; use autodie;
use XML::LibXML;
use LWP::Simple;

my $schemafile = 'UANodeSet.xsd';

if (scalar @ARGV > 0) {
    my $url = $ARGV[0];
    print("Parsing $url...\n");
    my $doc = XML::LibXML->new->parse_file($url);

    print("Get root element...\n");
    my $root = $doc->documentElement();

    print("Get default namespace URI...\n");
    my $schemaurl = $root->lookupNamespaceURI("");
    print("Schema URI is: $schemaurl\n");

    print("Downloading schema...\n");
    unlink($schemafile) if (-f $schemafile);
    my $code = getstore($schemaurl, $schemafile);
    if ($code ne 200) {
        die("Download failed with HTTP error $code\n");
    }

    print("Creating schema instance...\n");
    my $xmlschema = XML::LibXML::Schema->new(location => $schemafile, recover => 1, no_network => 1);

    print("Validating schema...\n");
    $xmlschema->validate($doc);

    print("Schema validation successful.\n");
}


__END__

=head1 NAME

validate.pl - Schema validation for XML based OPC UA NodeSet files using LibXML.

This script parses the given XML files, downloads the referenced XML schema
and validates the file aginst this schema.

=head1 VERSION

This documentation refers to validate.pl version 0.0.1

=head1 USAGE

    validate.pl <nodeset.xml>

=head1 REQUIRED ARGUMENTS

=over

Filename of OPC UA Nodeset file.

=back

=head1 OPTIONS

None

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

Requires no configuration files or environment variables.


=head1 DEPENDENCIES

=over

=item * XML::LibXML

sudo apt install libxml-libxml-perl

=item * LWP::Simple

sudo apt install libwww-perl

=back

=head1 BUGS

None reported.
Bug reports and other feedback are most welcome.


=head1 AUTHOR

Gerhard Gappmeier C<< gerhard.gappmeier@ascolab.com >>


=head1 COPYRIGHT

Copyright (c) 2020, Gerhard Gappmeier C<< <gerhard.gappmeier@ascolab.com> >>. All rights reserved.

This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html)


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.


