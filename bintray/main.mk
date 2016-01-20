# DEPENDENCIES
#		- BINTRAY_REPO
#		- BINTRAY_PACKAGE_NAME
#		- BINTRAY_ORG
#		- VERSION
#		- BINTRAY_INCLUDE_PATTERN
#		- BINTRAY_UPLOAD_PATTERN
#
# OPTIONAL
# 	- BINTRAY_CONFIG_INPUT_DIR
#		- BINTRAY_CONFIG_OUTPUT_DIR

BINTRAY_CONFIG_INPUT_DIR := $MAKEUP_DIR/makeup-bag-deis/bintray
BINTRAY_CONFIG_OUTPUT_DIR ?= _scripts/ci

prep-bintray-json:
	@jq '.version.name |= "$(VERSION)"' \
		$(BINTRAY_CONFIG_INPUT_DIR)/bintray-template.json |\
		jq '.package.name |= "$(BINTRAY_PACKAGE_NAME)"' |\
		jq '.package.repo |= "$(BINTRAY_REPO)"' |\
		jq '.package.subject' |= "$(BINTRAY_ORG)"' |\
		jq '.files.includePattern' |= "$(BINTRAY_INCLUDE_PATTERN)"' |\
		jq '.files.uploadPattern' |= "$(BINTRAY_UPLOAD_PATTERN)"' \
	> $(BINTRAY_CONFIG_OUTPUT_DIR)/bintray-ci.json
