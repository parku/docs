BUILD_DIR=./
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile
PAGE_V4=index
PAGE_V5=v5

all: generate

generate-v4: $(BUILD_DIR)/$(PAGE_V4).html

generate-v5: $(BUILD_DIR)/$(PAGE_V5).html

$(BUILD_DIR)/$(PAGE_V4).html: $(COMMON_DEPS) v4/*
	NOCACHE=1 aglio -i v4/parku.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

$(BUILD_DIR)/$(PAGE_V5).html: $(COMMON_DEPS) v4/* v5/*
	NOCACHE=1 aglio -i v5/parku.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

generate: $(BUILD_DIR)/$(PAGE_V4).html $(BUILD_DIR)/$(PAGE_V5).html

clean:
	rm -rf index.html v5.html
