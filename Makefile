DOCS=$(basename $(notdir $(wildcard templates/*.jemdoc)))

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix build/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)
	cp static/* build/
	cp css/* build/

build/%.html : templates/%.jemdoc MENU config.conf
	python jemdoc.py -c config.conf -o $@ $<

.PHONY : clean
clean :
	-rm -f build/*