# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use Test;
BEGIN { plan tests => 2 };
use Lexical::Typeglob 'lexglob';

# First test lexglob()
$sym1 = lexglob;
ok( ref($sym1) eq 'GLOB' );

$sym2 = lexglob;

ok( $sym1 ne $sym2 );

$sym1 = $sym2 = undef;

