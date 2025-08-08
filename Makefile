MAIN_FILE=main.go
TEST_FILE=main_test.go
BINARY_NAME=modlishka
BINARY_LINUX=$(BINARY_NAME)_linux
BINARY_WINDOWS=$(BINARY_NAME)_windows
BINARY_BSD=$(BINARY_NAME)_freebsd

GO=go
GOBUILD=$(GO) build
GOCLEAN=$(GO) clean
GOTEST=$(GO) test
GOGET=$(GO) get

.DEFAULT_GOAL := all
.PHONY: test

DIST_DIR=.
TEST_DIR=
all: test build
build:
	$(GOBUILD) -ldflags "-s -w" -o $(BINARY_NAME) $(MAIN_FILE)
test:
	$(GOTEST) -v $(MAIN_FILE) $(TEST_FILE)
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_LINUX)
	rm -f $(BINARY_WINDOWS)
	rm -f $(BINARY_BSD)

deps:
	$(GOGET) ./..


build_linux: test linux
build_linux_xgo: test linux
build_windows: test windows
build_windows_xgo: test windows
build_freebsd: test freebsd

linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -ldflags "-s -w" -o $(BINARY_LINUX) $(MAIN_FILE)

windows:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -ldflags "-s -w" -o $(BINARY_WINDOWS) $(MAIN_FILE)

freebsd:
	GOOS=freebsd GOARCH=amd64 $(GOBUILD) -ldflags "-s -w" -o $(BINARY_BSD) $(MAIN_FILE)

linux_amd64_xgo:
	xgo --targets=linux/amd64  --dest ./

linux_386_xgo:
	xgo --targets=linux/386  --dest ./

windows_xgo:
	xgo --targets=windows/amd64  --dest ./

freebsd_xgo:
	xgo --targets=freebsd/amd64  --dest ./


