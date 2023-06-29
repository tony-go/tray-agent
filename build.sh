mkdir -p dist

cd dist

cmake ..

cmake --build .

open ./TrayAgent.app

cd ..

