use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Lexical::Typeglob',
    'VERSION_FROM'	=> 'Typeglob.pm',
    ($] >= 5.005 ?
      (ABSTRACT_FROM => 'Typeglob.pm',
       AUTHOR     => 'Joshua b. Jore<jjore@cpan.org>') : ()),
    'LIBS'		=> [''],
    'DEFINE'		=> '',
    'INC'		=> '',
);
