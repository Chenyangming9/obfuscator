#undef signbit

#define __CLC_FUNCTION signbit
#define __CLC_BODY <clc/relational/unary_decl.inc>

#include <clc/relational/floatn.inc>

#undef __CLC_BODY
#undef __CLC_FUNCTION
