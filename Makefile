SUFFIXES = .rb .ui

RUBY = ruby
RBUIC = rbuic4

all: ui_gamewindow.rb ui_content.rb

test:
	$(RUBY) tc_battleship.rb

clean:
	rm -f ui_*.rb *~

ui_%.rb: %.ui
	$(RBUIC) $< > $@

