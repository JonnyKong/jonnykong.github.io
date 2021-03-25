DOCS=$(basename $(notdir $(wildcard templates/*.jemdoc)))

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix build/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)
	cp static/* build/
	cp css/* build/
	# jemdoc incorrectly sets file with "index" in the filename to be selected
	sed -i '' 's/ class="current"//g' build/index.html

build/%.html : templates/%.jemdoc MENU config.conf
	@mkdir -p build
	python jemdoc.py -c config.conf -o $@ $<

.PHONY : clean
clean :
	rm -rf build/