
export TESTBED_ROOT = $(CURDIR)

test:
	./test.sh

all:
	mako -j 4 -C deployment

clean:
	mako -j 4 -C deployment clean clean_deps

