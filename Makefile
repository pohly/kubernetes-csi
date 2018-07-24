# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

REGISTRY_NAME=quay.io/k8scsi
IMAGE_NAME=hostpathplugin
IMAGE_VERSION=canary
IMAGE_TAG=$(REGISTRY_NAME)/$*:$(IMAGE_VERSION)

REV=$(shell git describe --long --tags --match='v*' --dirty)

ifdef V
TESTARGS = -v -args -alsologtostderr -v 5
else
TESTARGS =
endif

.PHONY: all flexadapter nfs hostpath driver-registrar csi-attacher iscsi cinder clean

all: flexadapter nfs hostpath iscsi cinder driver-registrar csi-attacher csi-provisioner

flexadapter:
	CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o _output/flexadapter ./app/flexadapter
nfs:
	CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o _output/nfsplugin ./app/nfsplugin
iscsi:
	CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o _output/iscsiplugin ./app/iscsiplugin
cinder:
	CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o _output/cinderplugin ./app/cinderplugin

hostpath driver-registrar csi-attacher csi-provisioner:
	CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-X main.version=$(REV) -extldflags "-static"' -o _output/$@ ./cmd/$@

clean:
	go clean -r -x
	-rm -rf _output

%-container: %
	docker build -t $(IMAGE_TAG) -f ./cmd/$*/Dockerfile .

push-%: %-container
	docker push $(IMAGE_TAG)

push: push-hostpath push-driver-registrar push-csi-attacher push-csi-provisioner

# Must pass both locally and in Travis CI.
PACKAGES=$$(go list ./... | grep -v vendor)
test:
	go test $(PACKAGES) $(TESTARGS)
	go vet $(PACKAGES)
	[ $$(go fmt $(PACKAGES) | wc -l) = 0 ]
