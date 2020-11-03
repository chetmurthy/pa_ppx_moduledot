# Makefile,v
# Copyright (c) INRIA 2007-2017

TOP=.
include $(TOP)/config/Makefile

WD=$(shell pwd)
DESTDIR=
RM=rm

SYSDIRS= pa_moduledot

TESTDIRS= tests

PACKAGES := pa_ppx.utils,pa_ppx.base

all: sys
	set -e; for i in $(TESTDIRS); do cd $$i; $(MAKE) all; cd ..; done

sys: plugins

plugins:
	set -e; for i in $(SYSDIRS); do cd $$i; $(MAKE) all; cd ..; done

doc: all
	set -e; for i in $(SYSDIRS); do cd $$i; $(MAKE) doc; cd ..; done
	rm -rf docs
	tools/make-docs pa_ppx_moduledot docs
	make -C doc html

test: all
	set -e; for i in $(TESTDIRS); do cd $$i; $(MAKE) test; cd ..; done

install: sys
	$(OCAMLFIND) remove pa_ppx_moduledot || true
	$(OCAMLFIND) install pa_ppx_moduledot local-install/lib/pa_ppx_moduledot/*

uninstall:
	$(OCAMLFIND) remove pa_ppx_moduledot || true

clean::
	set -e; for i in $(SYSDIRS) $(TESTDIRS); do cd $$i; $(MAKE) clean; cd ..; done
	rm -rf docs local-install

depend:
	set -e; for i in $(SYSDIRS) $(TESTDIRS); do cd $$i; $(MAKE) depend; cd ..; done
