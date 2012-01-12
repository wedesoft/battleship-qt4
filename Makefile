SUFFIXES = .rb .ui .cc .hh

CXXOPTS = -I/usr/include/qt4
LDADD = -lQtGui -lQtSvg -lQtCore

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc
UIC = uic-qt4
MOC = moc-qt4
RCC = rcc

RUBYUI = ui_gamewindow.rb ui_content.rb qrc_battleship.rb
CCUI = ui_gamewindow.hh ui_content.hh
OBJECTS = battleship.o gamewindow.o game.o boardview.o content.o player.o
MOC_OBJECTS = moc_gamewindow.o moc_boardview.o moc_content.o
RCCOBJ = qrc_battleship.o

default: battleship

all: default ruby

battleship: $(CCUI) $(OBJECTS) $(MOC_OBJECTS) $(RCCOBJ)
	$(CXX) -o $@ $(OBJECTS) $(MOC_OBJECTS) $(RCCOBJ) $(LDADD)

ruby: $(RUBYUI)

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -Rf ui_*.rb ui_*.hh *.o *~ .deps

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

ui_%.hh: %.ui
	$(UIC) $< > $@

moc_%.cc: %.hh
	$(MOC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@

qrc_%.cc: %.qrc
	$(RCC) $< > $@

-include $(wildcard .deps/*.P) :-)

