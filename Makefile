CMAKE = cmake
CMAKE_FLAGS = -DCMAKE_BUILD_TYPE=Debug

all: configure build

configure:
	$(CMAKE) $(CMAKE_FLAGS) -B dist -G "Xcode"

build: configure
	$(CMAKE) --build dist --config Debug

test: build
	./test.sh
