mkdir -p dist

cd dist

cmake .. -G "Xcode" -DCMAKE_BUILD_TYPE=Debug

cmake --build .

open ./TrayAgent.app

cd ..

