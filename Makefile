DOCS=$(basename $(notdir $(wildcard templates/*.jemdoc)))

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix build/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	@echo -n $(PHDOCS)
	# insert code for copying to server here.
	@echo ' done.'

build/%.html : templates/%.jemdoc MENU
	python jemdoc.py -c config.conf -o $@ $<

.PHONY : clean
clean :
	-rm -f build/*.html