rm -rf dist

mkdir -p dist

cd dist

cmake .. -G "Xcode"

cmake --build .

cd ..


