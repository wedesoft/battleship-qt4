SUFFIXES = .rb .ui .cc .hh

RUBY = ruby
RBUIC = rbuic4
RBRCC = rbrcc

all: ui_gamewindow.rb ui_content.rb qrc_battleship.rb

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -f ui_*.rb *~

ui_%.rb: %.ui
	$(RBUIC) $< > $@

qrc_%.rb: %.qrc
	$(RBRCC) $< > $@


