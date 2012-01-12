SUFFIXES = .rb .ui

RBUIC = rbuic4

all: ui_gamewindow.rb ui_content.rb

clean:
	rm -f ui_*.rb *~

ui_%.rb: %.ui
	$(RBUIC) $< > $@

