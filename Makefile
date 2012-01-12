SUFFIXES = .rb .ui .cc .hh

CFLAGS = -I/usr/include/qt4
LDADD = -lQtGui -lQtCore

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc

OBJECTS = battleship.o

default: battleship

all: default ruby

battleship: $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDADD)

ruby: ui_gamewindow.rb ui_content.rb qrc_battleship.rb

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -f ui_*.rb *.o *~

.cc.o:
	$(CXX) -c -o $@ $(CFLAGS) $<

ui_%.rb: %.ui
	$(RBUIC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@


