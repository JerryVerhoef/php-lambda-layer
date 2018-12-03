ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
export BUCKET_PREFIX?=stackery-layers
export LAYERNAME?=php71

layer.zip: build.sh bootstrap
	docker run --rm -v $(ROOT_DIR):/opt/layer lambci/lambda:build-nodejs8.10 /opt/layer/build.sh

upload: layer.zip
	./upload.sh

publish: layer.zip
	./publish.sh

clean:
	rm php71.zip
