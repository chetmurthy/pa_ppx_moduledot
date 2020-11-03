A PPX Rewriter for Implementing Extended Module Exprs in Expressions

### Version

This is ``pa_ppx_moduledot`` (alpha) version 0.07.

# A Warning

This is very experimental code: use at your own risk.  For certain
there are many cases left unhandled, but it's fresh-baked code after
all.

# Overview

Emile Trotignan proposed that we should allow things like
```
Set.Make(String).empty
```
to expand to
```
let module __M__ = Set.Make(String) in __M__.empty
```

which is currently forbidden, b/c the module-expression
`Set.Make(String)` is an extended-module-path, not a module-path.
This PPX rewriter is a little prototype to allow that syntax.  So this rewriter expands
```
[%module Set.Make(String)].empty
```
to the above right-hand-side.

## Installation

To install, you need pre-release versions of `camlp5` and `pa_ppx`.  Here's a little script to get 'em:


```
opam pin remove camlp5 pa_ppx
opam pin -y -n add camlp5 https://github.com/camlp5/camlp5.git
opam pin -y -n add pa_ppx https://github.com/camlp5/pa_ppx.git
opam install -y -t pa_ppx
```

Then you can just
```
opam install .
```

or (more traditionally)
```
make sys test
```
