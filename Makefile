BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses


FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
ALLSENTEDBOOKS=$(BOOKS:all=results/all.sent.txt)
ALLFREQLIST=$(BOOKS:all=results/all.freq.txt)

all: $(FREQLISTS) $(SENTEDBOOKS) $(ALLSENTEDBOOKS) $(ALLFREQLIST)

clean:
	rm -f results/* data/*no_md.txt

%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< $@

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@

data/all.no_md.txt: data/alice.no_md.txt data/christmas_carol.no_md.txt data/dracula.no_md.txt data/frankenstein.no_md.txt data/heart_of_darkness.no_md.txt data/life_of_bee.no_md.txt data/moby_dick.no_md.txt data/modest_propsal.no_md.txt data/pride_and_prejudice.no_md.txt data/tale_of_two_cities.no_md.txt data/ulysses.no_md.txt
	cat $^ > $@ 

results/all.freq.txt: data/all.no_md.txt
	src/freqlist.sh $< $@

results/all.sent.txt: data/all.no_md.txt
	src/sent_per_line.sh $< $@
