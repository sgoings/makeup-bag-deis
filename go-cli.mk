# DEPENDENCIES
#		- PROJECT_NAME
#		- GO_CLI_ORG_NAME

# GOLANG DEFAULTS
export GO15VENDOREXPERIMENT=1
GO_CLI_BIN_DIR ?= bin
GO_CLI_MAIN ?= main.go
GO_CLI_BIN_NAME ?= $(PROJECT_NAME)
GO_CLI_SRC_PACKAGES ?= "./..."

.PHONY: go-cli-build go-cli-prebuild
go-cli-build: $(GO_CLI_MAIN) go-cli-glide-install go-cli-prebuild
	go build -o $(GO_CLI_BIN_DIR)/$(GO_CLI_BIN_NAME) -ldflags "-X main.version=${VERSION}" $<

.PHONY: go-cli-test
go-cli-test:
	go test -v $(GO_CLI_SRC_PACKAGES)

.PHONY: go-cli-clean
go-cli-clean:
	rm -rf $(GO_CLI_BIN_DIR)

.PHONY: go-cli-lint
go-cli-lint:
	go get github.com/golang/lint/golint
	@for i in . $(GO_CLI_SRC_PACKAGES); do \
		golint $$i; \
	done

.PHONY: go-cli-vet
go-cli-vet:
	@for i in . $(GO_CLI_SRC_PACKAGES); do \
		go vet github.com/$(GO_CLI_ORG_NAME)/$(PROJECT_NAME)/$$i; \
	done

.PHONY: go-cli-fmt
go-cli-fmt:
	gofmt -e -l -s *.go $(GO_CLI_SRC_PACKAGES)

.PHONY: go-cli-install
go-cli-install: go-cli-build
	install -d ${DESTDIR}/usr/local/bin/
	install -m 755 $(GO_CLI_BIN_DIR)/$(GO_CLI_BIN_NAME) ${DESTDIR}/usr/local/bin/$(GO_CLI_BIN_NAME)

.PHONY: go-cli-glide-install
go-cli-glide-install:
	glide install

.PHONY: go-cli-glide-install
go-cli-glide-update:
	glide update
