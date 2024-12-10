
     
#download mssql driver

cd i2b2-wildfly/customization/
export jdbc_mssql_driver_version=${jdbc_mssql_driver_version:-7.4.1}
export jdbc_mssql_driver_download_url=https://github.com/Microsoft/mssql-jdbc/releases/download/v${jdbc_mssql_driver_version}/mssql-jdbc-${jdbc_mssql_driver_version}.jre8.jar
curl -SOLs ${jdbc_mssql_driver_download_url}

export jdbc_pg_driver_version=${jdbc_pg_driver_version:-42.2.8}
export jdbc_pg_driver_download_url=https://jdbc.postgresql.org/download/postgresql-${jdbc_pg_driver_version}.jar
curl -SOLs ${jdbc_pg_driver_download_url}

#cp /tmp/workspace/i2b2.war .

cd ../../


#get latest version tag
TAG=$(curl https://api.github.com/repos/i2b2/i2b2-core-server/releases/latest | grep "tag_name"|cut -d: -f2|tr -d ",\" ")

echo $TAG
#compile image
docker build --no-cache -t i2b2/i2b2-wildfly:release-$TAG	 i2b2-wildfly


