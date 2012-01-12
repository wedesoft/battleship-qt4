SUFFIXES = .rb .ui .cc .hh

CFLAGS = -I/usr/include/qt4
LDADD = -lQtGui -lQtCore

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc
UIC = uic-qt4


RUBYUI = ui_gamewindow.rb ui_content.rb qrc_battleship.rb
CCUI = ui_gamewindow.hh ui_content.hh
OBJECTS = battleship.o gamewindow.o

default: battleship

all: default ruby

battleship: $(CCUI) $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDADD)

ruby: $(RUBYUI)

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -f ui_*.rb ui_*.hh *.o *~

.cc.o:
	$(CXX) -c -o $@ $(CFLAGS) $<

ui_%.rb: %.ui
	$(RBUIC) $< > $@

ui_%.hh: %.ui
	$(UIC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@


