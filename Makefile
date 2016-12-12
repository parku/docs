# shell modification for wild cards
SHELL=/bin/bash -O extglob -c

# output build files into current directory as github expects them in
# the root directory
BUILD_DIR=./build
GENERATED_DIR=./build/generated
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile | ./tmp

 # current stable version gets index assigned
INDEX=v4

PUBLISH_TO_BRANCH=gh-pages
GENERATE_VERSIONS=v4
# files to use for building v4
v4_SRC:=$(addprefix v4/, \
	parku.apib \
	types.apib \
	attributes.apib \
	authentication.apib \
	bookings.apib \
	cars.apib \
	coupon.apib \
	devices.apib \
	errors.apib \
	facebook.apib \
	invitations.apib \
	locations.apib \
	login.apib \
	password.apib \
	payment.apib \
	phone_numbers.apib \
	sesam.apib \
	settings.apib \
	static_pages.apib \
	user.apib \
	violations.apib \
	voucher.apib \
	changelog.md)

# files to use for building v5
v5_SRC:= \
	v5/parku.apib \
	v5/types.apib \
	v5/attributes.apib \
	v4/authentication.apib \
	v5/bookings.apib \
	v4/cars.apib \
	v4/coupon.apib \
	v4/devices.apib \
	v4/errors.apib \
	v4/facebook.apib \
	v4/invitations.apib \
	v5/locations.apib \
	v4/login.apib \
	v5/onstreet.apib \
	v5/orders.apib \
	v4/password.apib \
	v5/payment.apib \
	v4/phone_numbers.apib \
	v4/sesam.apib \
	v4/settings.apib \
	v4/static_pages.apib \
	v5/user.apib \
	v4/violations.apib \
	v5/changelog.md

MOCK_VERSION=v4

all: generate-html generate-swagger generate-apib meta-files

clean:
	rm -rf $(GENERATED_DIR) $(BUILD_DIR) $(PUBLISH_TO_BRANCH) tmp

meta-files: CNAME robots_allow.txt robots.txt | $(BUILD_DIR)
	cp CNAME robots.txt robots_allow.txt build

# Build version v5 from v5 sources
$(BUILD_DIR)/%.html: $(GENERATED_DIR)/%.apib $(COMMON_DEPS)
	NOCHACHE=1 aglio -i $(GENERATED_DIR)/$*.apib -o $(BUILD_DIR)/$*.html --theme peperoncino --theme-full-width --theme-template triple --verbose

# Build v4 and v5
generate-html: $(patsubst %, $(BUILD_DIR)/%.html, $(GENERATE_VERSIONS))
	mv $(BUILD_DIR)/$(INDEX).html $(BUILD_DIR)/index.html

generate-apib: $(patsubst %, $(GENERATED_DIR)/%.apib, $(GENERATE_VERSIONS))

generate-swagger: $(patsubst %, $(GENERATED_DIR)/%.swagger.json, $(GENERATE_VERSIONS))

# directory targets
$(GENERATED_DIR):
	mkdir $(GENERATED_DIR) -p

./tmp:
	mkdir tmp -p

$(BUILD_DIR):
	mkdir $(BUILD_DIR) -p

$(BUILD_DIR)/images/*: |images/* $(BUILD_DIR)
	cp images $(BUILD_DIR)/images -r

$(GENERATED_DIR)/%.no-headers: $(GENERATED_DIR)/%.apib
	sed '/Authorization\: Basic.*/d' $(GENERATED_DIR)/$*.apib > $(GENERATED_DIR)/$*.no-headers
	sed 's/\(POST \/\)/\1v4\//g' $(GENERATED_DIR)/$*.no-headers -i
	sed 's/\(GET \/\)/\1v4\//g' $(GENERATED_DIR)/$*.no-headers -i
	sed 's/\(PUT \/\)/\1v4\//g' $(GENERATED_DIR)/$*.no-headers -i
	sed 's/\(DELETE \/\)/\1v4\//g' $(GENERATED_DIR)/$*.no-headers -i
	sed 's/\(\[\/\)/\1v4\//g' $(GENERATED_DIR)/$*.no-headers -i

$(GENERATED_DIR)/%.apib: ./tmp ./$(GENERATED_DIR) $($*_SRC)
	mkdir tmp/$* -p
	cp $($*_SRC) tmp/$*/ -r
	sed -i -e 's/{{apiversion}}/$*/g' tmp/$*/*
	cat $(addprefix tmp/$*/, $(notdir $($*_SRC))) > $@

$(GENERATED_DIR)/%.swagger.json: $(GENERATED_DIR)/%.apib
	apib2swagger -i $(GENERATED_DIR)/$*.apib -o $@

# Docker targets
dev-docs-docker-image:
	docker build -t parku-dev-docs .

all-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make all'

clean-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make clean'

publish:
	$(eval GIT_COMMIT:=`git rev-parse HEAD`)
	rm -rf $(PUBLISH_TO_BRANCH)
	git clone -b $(PUBLISH_TO_BRANCH) git@github.com:parku/docs.git $(PUBLISH_TO_BRANCH)
	rm -rf $(PUBLISH_TO_BRANCH)/*
	cp $(BUILD_DIR)/* -r $(PUBLISH_TO_BRANCH)/
	cd gh-pages && git add . && git add -u && git commit -m "Updated documentation from commit $(GIT_COMMIT)"
	cd gh-pages && git push

$(GENERATED_DIR)/%-no-host.swagger.json: $(GENERATED_DIR)/%.swagger.json
	sed '/\"host\"\:.*/d' $(GENERATED_DIR)/$*.swagger.json > $(GENERATED_DIR)/$*-no-host.swagger.json

prism-mock: $(patsubst %, $(GENERATED_DIR)/%-no-host.swagger.json, $(GENERATE_VERSIONS))
	prism run --mockDynamic --list -p 80 -s build/generated/*-no-host.swagger.json

drakov-mock: $(GENERATED_DIR)/$(MOCK_VERSION).no-headers
	drakov -f build/generated/$(MOCK_VERSION).no-headers -p 80 --public

deploy-ecs:
	bash deploy/deploy_ecs.sh ${BRANCH_NAME}

.PHONY: mock prepare-ecs
