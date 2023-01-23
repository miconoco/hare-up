PREFIX := $(HOME)/.local

all: qbe/qbe harec/build/harec hare/.bin/hare


qbe:
	@mkdir -p $@
	@curl -sSfL https://c9x.me/git/qbe.git/snapshot/qbe-master.tar.gz | tar --strip-components=1 -xzf - -C $@

qbe/qbe: qbe
	@printf 'mk qbe\n'
	@$(MAKE) -s -C qbe PREFIX=$(PREFIX)


harec:
	@git -C $@ pull --rebase || git clone --depth 1 https://git.sr.ht/~sircmpwn/harec

harec/build/harec: harec qbe/qbe
	@printf 'mk harec\n'
	@mkdir -p harec/build
	@cd harec/build && QBE=$(CURDIR)/qbe/qbe ../configure --prefix=$(PREFIX)
	@$(MAKE) -s -C harec/build


hare:
	@git -C $@ pull --rebase || git clone --depth 1 https://git.sr.ht/~sircmpwn/hare

hare/config.mk:
	@sed 's:^PREFIX =.*$$:PREFIX = $(PREFIX):;s:^HAREC =.*$$:HAREC = $(CURDIR)/harec/build/harec:;s:^QBE =.*$$:QBE = $(CURDIR)/qbe/qbe:;s:^SCDOC =.*$$:SCDOC = $(CURDIR)/scdoc/scdoc:' hare/config.example.mk > $@

hare/.bin/hare: hare/config.mk harec/build/harec
	@$(MAKE) -s -C hare


scdoc:
	git -C $@ pull --rebase || git clone --depth 1 https://git.sr.ht/~sircmpwn/scdoc

scdoc/scdoc:
	$(MAKE) -s -C $(@D) PREFIX=$(PREFIX)


install: all
	@$(MAKE) -s -C qbe PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C harec/build $@
	@$(MAKE) -s -C hare $@

uninstall:
	@$(MAKE) -s -C hare $@
	@$(MAKE) -s -C harec/build $@
	@rm -f -- $(PREFIX)/qbe


clean:
	@-$(MAKE) -s -C qbe $@
	@-$(MAKE) -s -C harec/build $@
	@-$(MAKE) -s -C hare $@
	@rm -f -- hare/config.mk

distclean:
	@rm -rf -- qbe harec hare scdoc

.PHOMNY: all clean distclean install uninstall
