XSLT = xsltproc
#DOCBOOK_XSL_DIR = /opt/docbook-xsl
DOCBOOK_XSL_DIR = /usr/share/xml/docbook/stylesheet/docbook-xsl
#DOCBOOK_XSL_DIR = /usr/share/sgml/docbook/xsl-stylesheets
#DOCBOOK_XSL = $(DOCBOOK_XSL_DIR)/html/docbook.xsl
#DOCBOOK_CHUNK_XSL = $(DOCBOOK_XSL_DIR)/html/chunk.xsl
#MAKEINFO = makeinfo
TEXI2HTML = texi2html
MAKEINFO = $(TEXI2HTML)
#MAKEINFO = /home/bothner/GNU/texinfo-4.13/makeinfo/makeinfo
KAWA_DOC_SRC = /home/andrebask/Programmazione/Projects/Kawa/code_mod/doc
#KAWA_DOC_SRC = /home/bothner/Kawa/unmodified/doc
TUTORIAL_SRC = /home/andrebask/Programmazione/Projects/Kawa/code_mod/doc/tutorial.xml

all: internals/index.html

internals/index.html: internals.xml Makefile internals/internals.xsl
	$(XSLT) --path $(DOCBOOK_XSL_DIR)/xhtml \
	  --stringparam base.dir internals/ \
	  --stringparam generate.section.toc.level 0 \
	  --stringparam toc.max.depth 2 \
	  --stringparam toc.list.type ul \
	  --stringparam toc.section.depth 3 \
	  --stringparam use.id.as.filename 1 \
	  --stringparam chunker.output.indent yes \
	  internals/internals.xsl $<

# The following need to be fixed to avoid hardwired paths.
TransformToLatex.class:
	ln -s /home/bothner/public_html/papers/Freenix00/TransformToLatex.class .
usenix.sty:
	ln -s /home/bothner/public_html/papers/Freenix00/usenix.sty .
internals.tex: $(srcdir)/internals.xml TransformToLatex.class
	CLASSPATH=$(XSL_CLASSPATH) \
	  $(JAVA) TransformToLatex $(srcdir)/internals.xml /home/bothner/public_html/papers/Freenix00/docbook-to-latex.xsl internals.tex
internals.dvi: internals.tex usenix.sty
	latex internals.tex
internals.ps: internals.dvi
	dvips -o internals.ps internals.dvi

kawa.xml: $(KAWA_DOC_SRC)/kawa.texi
	$(MAKEINFO) -I=$(KAWA_DOC_SRC) --docbook $(KAWA_DOC_SRC)/kawa.texi -o - | \
	sed \
	-e 's|id="Top".*>|\0<?dbhtml filename="index.html"?>|' \
	-e 's|<title>Compiling to byte-code or an executable</title>|\0<titleabbrev>Compiling</titleabbrev>|' \
	-e 's|<title>Scheme Extensions and Language Reference</title>|\0<titleabbrev>Language Reference</titleabbrev>|' \
	-e 's|<title>Summary of Kawa Scheme Features</title>|\0<titleabbrev>Feature Summary</titleabbrev>|' \
	-e 's|<title>Input, output, and file handling</title>|\0<titleabbrev>Input, output, files</titleabbrev>|' \
	-e 's|<title>How to start up and run Kawa</title>|\0<titleabbrev>Usage Reference</titleabbrev>|' \
	-e 's|<title>Technical Support for Kawa</title>|\0<titleabbrev>Technical Support</titleabbrev>|' \
	-e 's|<title>Quantities and Numbers</title>|\0<titleabbrev>Numbers</titleabbrev>|' \
	-e 's|<title>Features of Kawa Scheme</title>|\0<titleabbrev>Scheme Features</titleabbrev>|' \
	-e 's|<title>Building and installing Kawa</title>|\0<titleabbrev>Building and installing</titleabbrev>|' \
	-e 's|<title>The Kawa Scheme system</title>|\0<titleabbrev>Kawa Home</titleabbrev>|' \
	-e '/@ifnotdocbook/,/@end ifnotdocbook/d' \
	> kawa.xml

hman/index.html: $(KAWA_DOC_SRC)/kawa.texi
	$(MAKEINFO) -I$(KAWA_DOC_SRC) --html kawa.texi -o hman

add-titleabbrev: kawa.xml

SAXON_JAR = /usr/share/java/saxonb.jar
#java -jar $(SAXON_JAR) [options]   source-document   stylesheet   [ params...] 
#options]   source-document   stylesheet   [ params...] 
#java -jar saxon8.jar -t samples\data\books.xml 

# make manual - but using Saxon.
manuals: kawa.xml Makefile manual-toc.xml
	java -jar $(SAXON_JAR) kawa.xml style/kawa.xsl \
	  root.filename=TOP \
	  generate.section.toc.level=0 \
	  chunker.output.encoding=UTF-8 \
	  chunker.output.doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" \
	  generate.index=1 \
	  use.id.as.filename=1 \
	  chunker.output.indent=yes \
	  chunk.first.sections=1 \
	  chunk.toc=manual-toc.xml \
	  chunk.section.depth=1 \
	  chapter.autolabel=0

manual: kawa.xml Makefile
	$(XSLT) --path $(DOCBOOK_XSL_DIR)/html \
	  --output ./  \
	  --stringparam root.filename toc \
	  --stringparam generate.section.toc.level 0 \
	  --stringparam chunker.output.encoding UTF-8 \
	  --stringparam chunker.output.doctype-public "-//W3C//DTD HTML 4.01 Transitional//EN" \
	  --stringparam generate.index 1 \
	  --stringparam use.id.as.filename 1 \
	  --stringparam chunker.output.indent yes \
	  --stringparam chunk.first.sections 1 \
	  --stringparam chunk.section.depth 1 \
	  --stringparam chapter.autolabel 0 \
	  --stringparam chunk.fast 1 \
	  --stringparam toc.max.depth 4 \
	  --stringparam toc.list.type ul \
	  --stringparam toc.section.depth 3 \
	  --stringparam chunk.separate.lots 1 \
	  --stringparam chunk.tocs.and.lots 1 \
	  style/kawa.xsl kawa.xml
	sed -e '/navfooter/,/div/d' <bk01-toc.html >toc.html
	rm bk01-toc.html
#	  --stringparam chunk.toc manual-toc.xml
#	patch index.html <index.patch

manual-toc.raw: kawa.xml
	xsltproc --path /opt/docbook-xsl/html -output manual-toc.raw \
	  --stringparam use.id.as.filename 1 \
	  --stringparam chunk.tocs.and.lots 1 \
	  --stringparam chunk.first.sections 1 \
	  --stringparam chunk.section.depth 2 \
	  maketoc.xsl kawa.xml

#manual-toc.xml: manual-toc.raw manual-toc.patch
#	patch --output=manual-toc.xml  manual-toc.raw manual-toc.patch

manual-toc.xml: manual-toc.raw
	sed -e '/filename="ch..s..s/{' -e 'N' -e 'd' -e '}' \
	  -e '/filename="Top.html/{' -e 'N' -e 'd' -e '}' \
	  <manual-toc.raw > manual-toc.xml

tutorial/index.html: $(TUTORIAL_SRC) Makefile tutorial/toc.xml
	$(XSLT) --path $(DOCBOOK_XSL_DIR)/html \
	  --stringparam use.id.as.filename 1 \
	  --stringparam base.dir tutorial/ \
	  --stringparam chunk.toc `pwd`/tutorial/toc.xml \
	  --stringparam chunker.output.encoding UTF-8 \
	  --stringparam chunker.output.doctype-public "-//W3C//DTD HTML 4.01 Transitional//EN" \
  \
	  --stringparam generate.section.toc.level 0 \
	  --stringparam chunk.first.sections 0 \
	  --stringparam generate.index 1 \
	  --stringparam toc.max.depth 4 \
	  --stringparam toc.list.type ul \
	  --stringparam toc.section.depth 3 \
	  --stringparam chunker.output.indent yes \
	  --stringparam chunk.fast 1 \
	  --stringparam chunk.tocs.and.lots 1 \
	  --stringparam chunk.separate.lots 1 \
  \
	 style/tutorial.xsl \
	$(TUTORIAL_SRC)

tutorial/toc.xml: $(TUTORIAL_SRC)
	xsltproc --path /opt/docbook-xsl/html -output tutorial/toc.xml \
	  --stringparam use.id.as.filename 1 \
	  --stringparam chunk.tocs.and.lots 1 \
	  --stringparam chunk.first.sections 0 \
	  --stringparam chunk.section.depth 2 \
	  maketoc.xsl $(TUTORIAL_SRC)
