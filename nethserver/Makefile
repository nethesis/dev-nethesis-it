#
# Documentation Makefile
#

DOTFILES := $(shell find . -name '*.dot')
PNGFILES := $(addsuffix .png, $(basename ${DOTFILES}))
SVGFILES := $(addsuffix .svg, $(basename ${DOTFILES}))
THUMBS := $(addsuffix -thumb.png, $(basename ${DOTFILES}))

DOCURL=http://dev.nethesis.it/nethserver/

%-thumb.png: %.png
	convert $< -resize 200x200 $@

%.svg: %.dot
	dot -Tsvg $< >$@

%.png: %.dot
	dot -Tpng $< >$@

.PHONY: clean all sync

all: ${PNGFILES} ${SVGFILES} ${THUMBS}

sync: all rsync.list
	rsync -zar -e "ssh -p 2222 -c blowfish -l git"  -stats \
		--files-from=rsync.list \
		${PWD}/ git@dev.nethesis.it:/var/www/html/nethserver

rsync.list:
	rm -f $@;
	for TARGET in ${THUMBS} ${PNGFILES} ${SVGFILES}; do echo $$TARGET >>$@; done

clean:
	rm -f ${THUMBS} ${PNGFILES} ${SVGFILES} rsync.list *~


