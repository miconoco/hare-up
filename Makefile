PREFIX := $(HOME)/.local

all: scdoc/scdoc harec/build/harec hare/.bin/harec2 hare-ssh hare-json

hare harec hare-json hare-ssh scdoc:
	@git -C $@ pull --rebase || git clone --depth 1 https://git.sr.ht/~sircmpwn/$@

qbe:
	@mkdir -p $@
	@curl -sSfL https://c9x.me/git/qbe.git/snapshot/qbe-master.tar.gz | tar --strip-components=1 -xzf - -C $@

qbe/qbe: qbe
	@printf 'mk qbe\n'
	@$(MAKE) -s -C qbe PREFIX=$(PREFIX)

harec/build/harec: harec qbe/qbe
	@printf 'mk harec\n'
	@mkdir -p harec/build
	@cd harec/build && QBE=$(CURDIR)/qbe/qbe ../configure --prefix=$(PREFIX)
	@$(MAKE) -s -C harec/build

hare/config.mk: hare
	@sed 's:^PREFIX =.*$$:PREFIX = $(PREFIX):;s:^HAREC =.*$$:HAREC = $(CURDIR)/harec/build/harec:;s:^QBE =.*$$:QBE = $(CURDIR)/qbe/qbe:;s:^SCDOC =.*$$:SCDOC = $(CURDIR)/scdoc/scdoc:' hare/config.example.mk > $@

hare/.bin/harec2: hare/config.mk harec/build/harec
	@printf 'mk hare\n'
	@$(MAKE) -s -C hare

scdoc/scdoc: scdoc
	@printf 'mk scdoc\n'
	@$(MAKE) -s -C $(@D) PREFIX=$(PREFIX)
	@touch $@

install: all
	@$(MAKE) -s -C scdoc PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C qbe PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C harec/build $@
	@$(MAKE) -s -C hare $@
	@$(MAKE) -s -C hare-ssh PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C hare-json PREFIX=$(PREFIX) $@

uninstall:
	@$(MAKE) -s -C hare-json PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C hare-ssh PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C scdoc PREFIX=$(PREFIX) $@
	@$(MAKE) -s -C hare $@
	@rm -f -- $(PREFIX)/bin/qbe $(PREFIX)/bin/harec

clean:
	@-$(MAKE) -s -C qbe $@
	@-$(MAKE) -s -C harec/build $@
	@-$(MAKE) -s -C hare $@
	@-$(MAKE) -s -C scdoc $@
	@-$(MAKE) -s -C hare-ssh $@
	@-$(MAKE) -s -C hare-json $@
	@rm -f -- hare/config.mk

distclean:
	@rm -rf -- qbe harec hare scdoc hare-ssh hare-json

.PHOMNY: all clean distclean install uninstall
