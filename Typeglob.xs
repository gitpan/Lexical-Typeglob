#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

GV*
lexglob()
{
    register GV* gv;
    GV** gvp;
    HV* stash;

    /* Do a little rain-dance so the fake-stash is created and the new glob
       is fetched from it. */
    stash = newHV();
    gvp = (GV**)hv_fetch(stash, '\0', 0, TRUE);
    gv = *gvp;

    /* Turn the empty gv into a real glob */
    gv_init(gv, stash, '\0', 0, TRUE & GV_ADDMULTI);

    /* Delete the pseudo-hash I just created to satisfy gv_init() */
    /* GvSTASH(gv) = Nullhv;
       SvREFCNT_dec(stash); */

    /* Do some unnecessary house-cleaning. Setting the stash's name keeps
       *{lexglob()}{PACKAGE} happy while assigning "" (instead of Nullch)
       to GvNAME causes *{lexglob()}{NAME} to return "" instead of undef. */
    HvNAME(stash) = "";
    GvNAME(gv) = "";
    GvNAMELEN(gv) = 0;
#ifdef GvFILE
    /* Added after 5.005_03 */
    GvFILE(gv) = "Lexical::Typeglob";
#endif
    GvLINE(gv) = 0;

    return gv;
}

MODULE = Lexical::Typeglob    PACKAGE = Lexical::Typeglob

PROTOTYPES: DISABLE

SV*
lexglob()
    CODE:
        RETVAL = newRV((SV*)lexglob());
    OUTPUT:
        RETVAL

SV*
lexioglob()
    INIT:
        GV* gv;
    CODE:
        gv = lexglob();
        GvIOp(gv) = newIO();
        RETVAL = newRV((SV*)gv);
    OUTPUT:
        RETVAL