SUFFIXES = .rb .ui .cc .hh

CFLAGS = -I/usr/include/qt4
LDADD = -lQtGui -lQtCore

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc
UIC = uic-qt4
MOC = moc-qt4

RUBYUI = ui_gamewindow.rb ui_content.rb qrc_battleship.rb
CCUI = ui_gamewindow.hh ui_content.hh
OBJECTS = battleship.o gamewindow.o game.o boardview.o content.o player.o
MOC_OBJECTS = moc_gamewindow.o moc_boardview.o moc_content.o

default: battleship

all: default ruby

battleship: $(CCUI) $(OBJECTS) $(MOC_OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(MOC_OBJECTS) $(LDADD)

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

moc_%.cc: %.hh
	$(MOC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@


