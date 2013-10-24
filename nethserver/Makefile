#
# Documentation Makefile
#

DOTFILES := $(shell find . -name '*.dot')
PNGFILES := $(addsuffix .png, $(basename ${DOTFILES}))
SVGFILES := $(addsuffix .svg, $(basename ${DOTFILES}))
THUMBS := $(addsuffix -thumb.png, $(basename ${DOTFILES}))
DOCURL=https://dev.nethesis.it
COMPS=nethserver-groups.html
TARGET ?= $(shell cat target 2>/dev/null)
TARGET ?= $(shell pwd)
TAG ?= $(shell git describe --tags | rev | cut -d '-' -f 3- | rev)

%-thumb.png: %.png
	convert $< -resize 200x200 $@

%.svg: %.dot
	dot -Tsvg $< >$@

%.png: %.dot
	dot -Tpng $< >$@

.PHONY: clean all sync

all: ${PNGFILES} ${SVGFILES} ${THUMBS} ${COMPS}

sync: all rsync.list
	rsync -zr -e "ssh -p 2222 -c blowfish -l davidep"  \
		--files-from=rsync.list \
		${PWD}/ $(TARGET)$(TAG)/

$(COMPS): comps2html.xsl comps/nethserver-groups.xml.in
	cd comps && make nethserver-groups.xml
	cat comps/nethserver-groups.xml | sed 's/_name/name/; s/_description/description/' | xsltproc --stringparam date "`LANG=C date`" --stringparam urlPrefix "$(DOCURL)" comps2html.xsl  - 2>/dev/null >$@

rsync.list:
	rm -f $@;
	for F in ${THUMBS} ${PNGFILES} ${SVGFILES} ${COMPS}; do echo $$F >>$@; done

clean:
	rm -rf ${THUMBS} ${PNGFILES} ${SVGFILES} ${TAGS} ${COMPS} *~ rsync.list


