SUFFIXES = .rb .ui .cc .hh .py

CXXOPTS = -I/usr/include/qt4
LDADD = -lQtGui -lQtSvg -lQtCore

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc
PYTHON = python
PYUIC = pyuic4
PYRCC = pyrcc4
UIC = uic-qt4
MOC = moc-qt4
RCC = rcc
TAR = tar
MKDIR = mkdir
CP = cp

RUBYUI = ui_gamewindow.rb qrc_battleship.rb
PYTHONUI = ui_gamewindow.py battleship_rc.py
CCUI = ui_gamewindow.hh
OBJECTS = battleship.o gamewindow.o game.o boardview.o player.o
MOC_OBJECTS = moc_gamewindow.o moc_boardview.o
RCCOBJ = qrc_battleship.o

SOURCES = battleship.cc boardview.cc game.cc gamewindow.cc player.cc \
	boardview.hh game.hh gamewindow.hh player.hh \
	battleship.rb boardview.rb game.rb gamewindow.rb player.rb tc_battleship.rb \
	battleship.py gamewindwo.py \
	gamewindow.ui battleship.qrc \
	battleship.svg carrier.svg destroyer.svg hit.svg miss.svg panel.svg patrol\ boat.svg \
	submarine.svg \
	Makefile Makefile.mingw Makefile.macos

default: all

all: cpp python ruby

cpp: battleship

dist: battleship.tar.bz2

battleship.tar.bz2: $(SOURCES)
	$(MKDIR) battleship
	$(CP) $(SOURCES) battleship
	$(TAR) cjf battleship.tar.bz2 battleship
	rm -Rf battleship

battleship: $(CCUI) $(OBJECTS) $(MOC_OBJECTS) $(RCCOBJ)
	$(CXX) -o $@ $(OBJECTS) $(MOC_OBJECTS) $(RCCOBJ) $(LDADD)

ruby: $(RUBYUI)

python: $(PYTHONUI)

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -Rf ui_*.rb ui_*.py qrc_*.rb *_rc.py ui_*.hh qrc_*.cc moc_*.cc *.o *.pyc *~ .deps battleship

DEPS_MAGIC := $(shell mkdir .deps > /dev/null 2>&1 || :)

.cc.o:
	$(CXX) -Wp,-MD,.deps/$(*F).pp -c $< -o $@ $(CXXOPTS)
	@-cp .deps/$(*F).pp .deps/$(*F).P; \
	tr ' ' '\012' < .deps/$(*F).pp \
	  | sed -e 's/^\\$$//' -e '/^$$/ d' -e '/:$$/ d' -e 's/$$/ :/' \
	    >> .deps/$(*F).P; \
	rm .deps/$(*F).pp

ui_%.rb: %.ui
	$(RBUIC) $< > $@

ui_%.py: %.ui
	$(PYUIC) $< > $@

ui_%.hh: %.ui
	$(UIC) $< > $@

moc_%.cc: %.hh
	$(MOC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@

%_rc.py: %.qrc
	$(PYRCC) $< > $@

qrc_%.cc: %.qrc
	$(RCC) $< > $@

-include $(wildcard .deps/*.P) :-)

