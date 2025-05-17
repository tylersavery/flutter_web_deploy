export RELEASE="0.0.1"


rm -rf ./build/web

flutter build web --release --base-href /$RELEASE/

mkdir -p build/web_output/$RELEASE
mv build/web/* build/web_output/$RELEASE
mv build/web_output/$RELEASE/index.html build/web_output/index.html
cp build/web_output/$RELEASE/version.json build/web_output/version.json


