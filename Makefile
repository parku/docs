BUILD_DIR=.
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile theme/* ./tmp
PAGE_V4=index
PAGE_V5=v5
SHELL=/bin/bash -O extglob -c

V4_SRC:=$(addprefix v4/, \
	attributes.apib \
	bookings.apib \
	cars.apib \
	changelog.md \
	coupon.apib \
	devices.apib \
	facebook.apib \
	invitations.apib \
	locations.apib \
	login.apib \
	parku.apib \
	password.apib \
	payment.apib \
	phone_numbers.apib \
	sesam.apib \
	settings.apib \
	static_pages.apib \
	user.apib \
	violations.apib \
	voucher.apib)

V5_SRC:=$(addprefix v4/, \
	attributes.apib \
	bookings.apib \
	cars.apib \
	changelog.md \
	coupon.apib \
	devices.apib \
	facebook.apib \
	invitations.apib) \
	v5/locations.apib \
	v4/login.apib \
	v5/parku.apib \
	$(addprefix v4/, \
	password.apib \
	payment.apib \
	phone_numbers.apib \
	sesam.apib \
	settings.apib \
	static_pages.apib \
	user.apib \
	violations.apib \
	voucher.apib)

all: generate generated/v4.apib generated/v4.swagger.json generated/v5.apib generated/v5.swagger.json

generate-v4: $(BUILD_DIR)/$(PAGE_V4).html

generate-v5: $(BUILD_DIR)/$(PAGE_V5).html

$(BUILD_DIR)/$(PAGE_V4).html: $(COMMON_DEPS) v4/*
	mkdir tmp/v4 -p
	cp $(V4_SRC) tmp/v4/ -r
	sed -i -e 's/{{apiversion}}/v4/g' tmp/v4/*
	NOCACHE=1 aglio -i tmp/v4/parku.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

$(BUILD_DIR)/$(PAGE_V5).html: $(COMMON_DEPS) v4/* v5/*
	mkdir tmp/v5 -p
	cp $(V5_SRC) tmp/v5/ -r
	sed -i -e 's/{{apiversion}}/v5/g' tmp/v5/*
	NOCACHE=1 aglio -i tmp/v5/parku.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

generate: $(BUILD_DIR)/$(PAGE_V4).html $(BUILD_DIR)/$(PAGE_V5).html

./generated:
	mkdir generated -p

./tmp:
	mkdir tmp -p

generated/%.apib: ./tmp ./generated v4/*
	cat tmp/$*/parku.apib | cat - tmp/$*/!(parku*).apib > $@

generated/%.swagger.json: generated/%.apib
	apib2swagger -i generated/$*.apib -o $@

clean:
	rm -rf index.html v5.html generated tmp
