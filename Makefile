SUFFIXES = .rb .ui

RBUIC = rbuic4

all: ui_game.rb

clean:
	rm -f ui_*.rb *~

ui_%.rb: %.ui
	$(RBUIC) $< > $@

