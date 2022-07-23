XPTemplate priority=personal

XPTinclude
      \ _common/common
      \ _common/common.path
      \ _comment/singleDouble
      \ _condition/c.like
      \ _func/c.like
      \ _loops/c.while.like
      \ _loops/java.for.like
      \ _preprocessor/c.like
      \ _structures/c.like
XPTinclude
      \ c/c

let s:f = g:XPTfuncs()

fun! s:f.headerGuard(...)
  let h = expand('%:p:.') " relative path
  let h = substitute(h, '\.', '_', 'g') " replace . with _
  let h = substitute(h, '\/', '_', 'g') " replace / with _
  let h = substitute(h, '-', '_', 'g') " replace - with _
  let h = substitute(h, '.', '\U\0', 'g') " make all characters upper case
  return '__'.h.'__'
endfunction

XPT constructor " Class::Class ()
`Type^::`Type^ (`cursor^)

XPT namespace " namespace {}
namespace `name^ {
`cursor^
} // namespace `name^
..XPT

XPT class   " class ..
class `className^ {
public:
    `className^(`ctorParam^);
    ~`className^();
    `cursor^
private:
};

`className^::`className^(`ctorParam^) {}

`className^::~`className^() {}

..XPT

XPT boolmethodoverride "
bool `className^::`methodName^(`params^) {
    if (!`parentName^::`methodName^(`params2^)) return false;
    `cursor^
    return true;
}

XPT main hint=main\ (argc,\ argv)
int main(int argc, char **argv) {
    `cursor^
    return 0;
}

XPT once " #ifndef .. #define ..
XSET symbol=headerGuard()
#ifndef `symbol^
#define `symbol^

`cursor^
#endif `$CL^ `symbol^ `$CR^
..XPT

XPT newheader hint=c++\ class\ header
XSET header_guard=headerGuard()
XSET export_upper=UpperCase( R('export_prefix') )
#ifndef `header_guard^
#define `header_guard^

#include "`path_to^/`export_prefix^_export.h"

namespace `ns^ {

class `export_upper^_EXPORT `className^ {
public:
    `className^(`ctorParam^);
    ~`className^()` override^;
    `cursor^
private:
};

} // namespace `ns^

#endif `$CL^ `header_guard^ `$CR^
..XPT

XPT exportguard
#ifndef __`MODULE^_EXPORT_H__
#define __`MODULE^_EXPORT_H__

#if defined(COMPONENT_BUILD)
#if defined(WIN32)

#if defined(`MODULE^_IMPLEMENTATION)
#define `MODULE^_EXPORT __declspec(dllexport)
#else
#define `MODULE^_EXPORT __declspec(dllimport)
#endif  // defined(`MODULE^_IMPLEMENTATION)

#else  // defined(WIN32)
#if defined(`MODULE^_IMPLEMENTATION)
#define `MODULE^_EXPORT __attribute__((visibility("default")))
#else
#define `MODULE^_EXPORT
#endif
#endif

#else  // defined(COMPONENT_BUILD)
#define `MODULE^_EXPORT
#endif

#endif /* __`MODULE^_EXPORT_H__ */
..XPT
