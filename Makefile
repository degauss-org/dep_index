.PHONY: build test shell clean

build:
	docker build -t dep_index .

test:
	docker run --rm -v "${PWD}/test":/tmp dep_index my_address_file_geocoded.csv

shell:
	docker run --rm -it --entrypoint=/bin/bash -v "${PWD}/test":/tmp dep_index

clean:
	docker system prune -f