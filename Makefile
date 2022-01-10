all:
	csc -o subst -O5 -d0 subst.scm

.PHONY: debug
debug:
	csc -o subst -d3 subst.scm

.PHONY: install
install:
	cp subst /usr/local/bin

.PHONY: uninstall
uninstall:
	rm /usr/local/bin/subst
