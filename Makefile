DOCS=$(basename $(notdir $(wildcard templates/*.jemdoc)))

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix build/, $(HDOCS))

.PHONY : docs
# jemdoc incorrectly sets file with "index" in the filename to be selected
docs : $(PHDOCS)
	cp static/* build/
	cp css/* build/
	if [[ "$(shell uname -s)" == "Darwin" ]]; then \
		sed -i '' 's/ class="current"//g' build/index.html;\
	else \
		sed -i 's/ class="current"//g' build/index.html;\
	fi

build/%.html : templates/%.jemdoc MENU config.conf
	@mkdir -p build
	python jemdoc.py -c config.conf -o $@ $<

.PHONY : clean
clean :
	rm -rf build/