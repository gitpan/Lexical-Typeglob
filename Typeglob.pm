package Lexical::Typeglob;

use strict;
use warnings;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);
our @EXPORT_OK = ( 'lexglob',
		   'lexioglob' );
our $VERSION = '0.02';

bootstrap Lexical::Typeglob $VERSION;

1;
__END__

=head1 NAME

Lexical::Typeglob - Like Symbol except without globals

=head1 SYNOPSIS

  use Lexical::Typeglob qw(lexglob lexioglob);

  my $glob = lexglob();
  open $glob, 'filename';
  $_ = $glob;
  # etc.

  # replace *FOO{IO} handle but not $FOO, %FOO, etc.
  *FOO = lexioglob();

=head1 DESCRIPTION

C<Lexical::Typeglob::lexglob> creates an anonymous glob and returns a
reference to it. Such a glob reference can be used as a file or directory
handle. This differs from C<Symbol::gensym> only in that the glob has no
symbol table component and the glob generation is four times as fast.

C<Lexical::Typeglob::lexioglob> creates an anonymous IO handle. This can be
assigned into an existing glob without affecting the non-IO portions of the
glob.

=head1 AUTHOR

Joshua b. Jore, E<lt>jjore@cpan.orgE<gt>

=head1 SEE ALSO

L<Symbol>.

=head1 COPYRIGHT AND LICENSE

Copyright 2003, Joshua b. Jore. All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of either:

a) the GNU General Public License as published by the Free Software
   Foundation; version 2, or

b) the "Artistic License" which comes with Perl.

=cut
