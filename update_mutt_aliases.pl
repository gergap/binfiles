#!/usr/bin/env perl
use 5.020;
use warnings;
use autodie;

my %mails;
while (<>) {
    next if (!/^From: (.*) <([\w.-]+@[\w.-]+)>/);
    # here you have the chance to filter garabage and spammers
    next if (/noreply/);
    next if (/\?.*\?/);
    # store mail and name
    $mails{$2} = $1;
}

# create alias list
foreach my $email (keys %mails) {
    my $name = $mails{$email};
    print "alias $name <$email>\n";
}

__END__

=head1 NAME

bin/update_mutt_aliases.pl - Creates an Mutt alias list from cached message bodies.

=head1 VERSION

This documentation refers to bin/update_mutt_aliases.pl version 0.0.1

=head1 USAGE

    bin/update_mutt_aliases.pl <file>

=head1 REQUIRED ARGUMENTS

=over

None

=back

=head1 OPTIONS

=over

None

=back

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

You can add this to your crontab to update your alias once or day or faster.

Example:

# update mutt aliases
0 * * * * user test -x ~/bin/update_mutt_aliases.pl && ~/bin/update_mutt_aliases.pl ~/.mutt/mailaccount/cache/bodies/* > ~/.mutt/aliases.generated


=head1 DEPENDENCIES

None.


=head1 BUGS

None reported.
Bug reports and other feedback are most welcome.


=head1 AUTHOR

Gerhard Gappmeier C<< gerhard.gappmeier@ascolab.com >>


=head1 COPYRIGHT

Copyright (c) 2021, Gerhard Gappmeier C<< <gerhard.gappmeier@ascolab.com> >>. All rights reserved.

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


