XPTemplate priority=personal

XPTinclude
      \ _common/common
      \ _comment/singleDouble
      \ _condition/c.like
      \ _func/c.like
      \ _loops/c.while.like
      \ _loops/java.for.like
      \ _preprocessor/c.like
      \ _structures/c.like
XPTinclude
      \ c/c

XPT constructor " Class::Class ()
`Type^::`Type^ (`cursor^)

XPT namespace " namespace {}
namespace `name^ {
`cursor^
} // namespace `name^
..XPT

XPT node   " blockit node ..
class `className^ : public `parentClass^ {
public:
    BT_DEFINE_TYPE(`className^, `parentClass^);

    `className^(`ctorParam^);
    ~`className^();
    `cursor^
private:
};

class `className^Class : public bt::GenericNodeClass<`className^, `parentClass^Class> {
public:
    virtual ~`className^Class() {}
};

`className^::`className^(`ctorParam^) {}

`className^::~`className^() {}

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

XPT btpropdef " property definitions
BT_BEGIN_PROPERTY_DEF(`className^);
BT_END_PROPERTY_DEF();
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
XSET symbol=headerSymbol()
#ifndef `symbol^
#define `symbol^

`cursor^
#endif `$CL^ `symbol^ `$CR^
