# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use Test;
BEGIN { plan tests => 7 };
use Lexical::Typeglob qw(lexglob lexioglob);
# First test lexglob()
$sym1 = lexglob;
ok( ref($sym1) eq 'GLOB' );
ok( UNIVERSAL::isa($sym1, 'GLOB') );
ok( *{$sym1}{PACKAGE} eq '' );
ok( *{$sym1}{NAME} eq '' );

$sym2 = lexglob;

ok( $sym1 != $sym2 );

$iosym = lexioglob;
ok( *{$iosym}{IO} );
ok( UNIVERSAL::isa(*{$iosym}{IO}, $] < 5.006 ? "FileHandle" : "IO" ) );
