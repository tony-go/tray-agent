CMAKE = cmake
CMAKE_FLAGS = -DCMAKE_BUILD_TYPE=Debug

all: configure build

configure:
	$(CMAKE) $(CMAKE_FLAGS) -B dist -G "Xcode"

build: configure
	$(CMAKE) --build dist --config Debug

test: dist
	./test.sh

open: dist
	./open.sh

kill:
	killall TrayAgent

clean: dist
	rm -rf dist

full: dist | kill build open
