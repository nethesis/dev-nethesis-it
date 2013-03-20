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
TAGS=v6.4-alpha2
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
	git archive --format=tar --prefix=$@/nethserver/  $@ . | tar xf -
	cd $@/nethserver
	make TAG=$@
	cd ..

sync: all rsync.list
	rsync -zr -e "ssh -p 2222 -c blowfish -l davidep"  \
		--files-from=rsync.list \
		${PWD}/ davidep@dev.nethesis.it:/var/www/html/sites/nethesis-redmine/public/nethserver/$(TAG)

comps.html:
	cat comps/comps-ns6.xml | sed 's/_name/name/; s/_description/description/' | xsltproc --stringparam date "`LANG=C date`" --stringparam urlPrefix https://dev.nethesis.it comps2html.xsl  - 2>/dev/null >$@


rsync.list:
	rm -f $@;
	for TARGET in ${THUMBS} ${PNGFILES} ${SVGFILES} ${ISOFILES}; do echo $$TARGET >>$@; done
	echo figures/ >>$@
	echo comps.html >>$@

clean:
	rm -rf ${THUMBS} ${PNGFILES} ${SVGFILES} ${TAGS} rsync.list *~


