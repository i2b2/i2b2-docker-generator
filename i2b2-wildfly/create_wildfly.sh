# installing apache ant
# wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.14-bin.tar.gz
# tar -zxvf apache-ant-1.10.14-bin.tar.gz
# export PATH=$PATH:~/apache-ant-1.10.14/bin/
apt-get install ant

wildfly_path="/root/i2b2-docker-generator/i2b2-wildfly"
TAG=$(curl https://api.github.com/repos/i2b2/i2b2-core-server/releases/latest | grep "tag_name"|cut -d: -f2|tr -d ",\" ")

cd $wildfly_path;
git clone --depth=1 --branch $TAG https://github.com/i2b2/i2b2-core-server.git;
cd i2b2-core-server/edu.harvard.i2b2.server-common && ant clean dist war;
cp dist/i2b2.war $wildfly_path/i2b2-wildfly/customization/;
cd $wildfly_path;
sh create_and_push_to_dockerhub.sh
