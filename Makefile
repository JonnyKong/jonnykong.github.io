DOCS=$(basename $(notdir $(wildcard templates/*.jemdoc)))

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix docs/, $(HDOCS))

.PHONY : docs
# jemdoc incorrectly sets file with "index" in the filename to be selected
docs : $(PHDOCS)
	cp static/* docs/
	cp css/* docs/
	if [[ "$(shell uname -s)" == "Darwin" ]]; then \
		sed -i '' 's/ class="current"//g' docs/index.html;\
	else \
		sed -i 's/ class="current"//g' docs/index.html;\
	fi

docs/%.html : templates/%.jemdoc MENU config.conf
	@mkdir -p docs
	python jemdoc.py -c config.conf -o $@ $<

.PHONY : clean
clean :
	rm -rf docs/