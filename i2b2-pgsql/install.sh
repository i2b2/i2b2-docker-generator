#!/bin/bash



# Pre-requisites - Install below softwares
# docker, docker-compose, git, unzip

I2B2_DATA_DIR="/root/github_release/dev_final/i2b2-docker-generator/i2b2-pgsql/i2b2-data/edu.harvard.i2b2.data/Release_1-8/NewInstall"
I2B2_WILDFLY_HOST="i2b2-wildfly"
I2B2_WILDFLY_PORT="8080"

echo "Pulling i2b2-data repository.."

git clone https://github.com/i2b2/i2b2-data.git -b v1.8.1a.0001
echo

echo "Unziping required files.."

unzip $I2B2_DATA_DIR/Crcdata/demo/scripts/postgresql/crcdata.zip -d $I2B2_DATA_DIR/Crcdata/demo/scripts/postgresql/
# unzip $I2B2_DATA_DIR/Crcdata/demo/scripts/postgresql/crcdata.zip -d $I2B2_DATA_DIR/Crcdata/demo/scripts/postgresql/
unzip $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/crcdata1.zip -d $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/crcdata2.zip -d $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/crcdata3.zip -d $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/crcdata4.zip -d $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/crcdataQT_BREAKDOWS_Postgres.zip -d $I2B2_DATA_DIR/Crcdata/act/scripts/postgresql/


unzip $I2B2_DATA_DIR/Metadata/demo/scripts/postgresql/metadata.zip -d $I2B2_DATA_DIR/Metadata/demo/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata1.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata2.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata3.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata4.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata5.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata6.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata7.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadata8.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/
unzip $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/metadataDEM_VISIT_RESEARCH_Postgresql.zip -d $I2B2_DATA_DIR/Metadata/act/scripts/postgresql/


echo

echo "Replacing host:port in Pmdata/scripts/demo/pm_access_insert_data.sql.."
sed -i "s/localhost:9090/$I2B2_WILDFLY_HOST:$I2B2_WILDFLY_PORT/g" $I2B2_DATA_DIR/Pmdata/scripts/demo/pm_access_insert_data.sql
echo

echo "Starting postgres docker container.."

docker compose up -d i2b2-pg
