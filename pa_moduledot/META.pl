#!/usr/bin/env perl

use strict ;
BEGIN { push (@INC, "..") }
use Version ;

our $destdir = shift @ARGV ;

print <<"EOF";
# Specifications for the "pa_ppx_moduledot" preprocessor:
version = "$Version::version"
description = "pa_ppx_moduledot deriver"

  requires(toploop) = "camlp5,pa_ppx.base"
  archive(toploop) = "pa_moduledot.cmo"

    requires(syntax,preprocessor) = "camlp5,pa_ppx.base"
    archive(syntax,preprocessor,-native) = "pa_moduledot.cmo"
    archive(syntax,preprocessor,native) = "pa_moduledot.cmx"

  package "link" (
  requires(byte) = "camlp5,pa_ppx.base.link"
  archive(byte) = "pa_moduledot.cmo"
  )

EOF
