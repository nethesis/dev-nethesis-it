#
# Documentation Makefile
#

DOTFILES := $(shell find . -name '*.dot')
PNGFILES := $(addsuffix .png, $(basename ${DOTFILES}))
SVGFILES := $(addsuffix .svg, $(basename ${DOTFILES}))
ISOFILES := $(shell find iso/ -name '*.iso*')
THUMBS := $(addsuffix -thumb.png, $(basename ${DOTFILES}))

DOCURL=http://dev.nethesis.it/nethserver/

ifndef TAG
TAGS=NSA1
endif

%-thumb.png: %.png
	convert $< -resize 200x200 $@

%.svg: %.dot
	dot -Tsvg $< >$@

%.png: %.dot
	dot -Tpng $< >$@

.PHONY: clean all sync

all: ${PNGFILES} ${SVGFILES} ${THUMBS} ${TAGS}

$(TAGS):
	git archive --format=tar --prefix=$@/ --remote ssh://git.nethesis.it/var/nethserver/dev-nethesis-it.git $@ nethserver/ | tar xf -
	cd $@/nethserver
	make TAG=$@
	cd ..

sync: all rsync.list
	rsync -zr -e "ssh -p 2222 -c blowfish -l davidep"  \
		--files-from=rsync.list \
		${PWD}/ davidep@dev.nethesis.it:/var/www/html/sites/nethesis-redmine/public/nethserver/$(TAG)

rsync.list:
	rm -f $@;
	for TARGET in ${THUMBS} ${PNGFILES} ${SVGFILES} ${ISOFILES}; do echo $$TARGET >>$@; done

clean:
	rm -rf ${THUMBS} ${PNGFILES} ${SVGFILES} ${TAGS} rsync.list *~


