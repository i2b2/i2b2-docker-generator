BASE=/i2b2-docker-generator/i2b2-web_final
cd $BASE
git clone -b v1.8.1a.0001 --depth=1 https://github.com/i2b2/i2b2-webclient.git #clone the latest tag

cd $BASE

sed -i 's/services.i2b2.org/i2b2-wildfly:8080/'   $BASE/i2b2-webclient/i2b2_config_domains.json
sed -i 's/debug: false/debug: true/'  $BASE/i2b2-webclient/i2b2_config_domains.json
sed -i 's#/~proxy#proxy.php#g'  $BASE/i2b2-webclient/i2b2_config_domains.json

sed -i 's#127.0.0.1:8080/#i2b2-wildfly:8080/#g'  $BASE/i2b2-webclient/proxy.php
sed -i 's#http://services.i2b2.org#http://i2b2-wildfly:8080#g' $BASE/i2b2-webclient/proxy.php



docker build -t local/i2b2-web:latest $BASE/
VERSION=$(curl https://api.github.com/repos/i2b2/i2b2-webclient/releases/latest | grep "tag_name"|cut -d: -f2|tr -d ",\" ")
echo "VERSION: ${VERSION}"
docker tag local/i2b2-web:latest i2b2/i2b2-web:release-$VERSION
