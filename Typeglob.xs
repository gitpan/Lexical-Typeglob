#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define PERL_MAGIC_glob '*'

MODULE = Lexical::Typeglob    PACKAGE = Lexical::Typeglob    PREFIX=lg_

PROTOTYPES: DISABLE

SV*
lg_lexglob()
    INIT:
        GV* gv;
        GV** gvp;
        HV* stash;
    CODE:
        /* Do a little rain-dance so the fake-stash is created and the new
	   glob is fetched from it. */
        stash = newHV();
        gvp = (GV**)hv_fetch(stash, '\0', 0, TRUE);
        gv = *gvp;

        /* Turn the empty gv into a real glob */
        gv_init(gv, stash, '\0', 0, TRUE & GV_ADDMULTI);

        /* Delete the pseudo-hash I just created to satisfy gv_init() */
        GvSTASH(gv) = Nullhv;
        SvREFCNT_dec(stash);

        /* Do some unnecessary house-cleaning. */
        GvNAME(gv) = Nullch;
        GvNAMELEN(gv) = 0;
        GvFILE(gv) = "Lexical::Typeglob";
        GvLINE(gv) = 0;

        RETVAL = newRV((SV*)gv);
    OUTPUT:
        RETVAL
