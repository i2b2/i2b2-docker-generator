#!/bin/bash

PG_USER="postgres"
BASE_DIR="/i2b2"
I2B2_DATA_DIR="$BASE_DIR/i2b2-data/edu.harvard.i2b2.data/Release_1-8/NewInstall"

CRCDATA_DIR="$I2B2_DATA_DIR/Crcdata"
HIVEDATA_DIR="$I2B2_DATA_DIR/Hivedata"
PMDATA_DIR="$I2B2_DATA_DIR/Pmdata"
METADATA_DIR="$I2B2_DATA_DIR/Metadata"
WORKDATA_DIR="$I2B2_DATA_DIR/Workdata"
export PGPASSWORD=demouser
# PGPASSWORD=demouser


I2B2_USER="i2b2"
I2B2_DEMODATA_USER="i2b2demodata"
I2B2_HIVE_USER="i2b2hive"
I2B2_IMDATA_USER="i2b2imdata"
I2B2_METADATA_USER="i2b2metadata"
I2B2_PM_USER="i2b2pm"
I2B2_WORKDATA_USER="i2b2workdata"

echo $BASE_DIR
echo "Creating i2b2 database.."
echo
psql -U $PG_USER -f "$BASE_DIR/create-db.sql"
echo 
echo "Creating i2b2 schema.."
echo
psql -U $I2B2_USER -w -f "$BASE_DIR/create-schema.sql"
echo


# ------------- CRCDATA--------------
echo "Creating CRC data tables.."
echo
for x in $(ls $CRCDATA_DIR/scripts/*_postgresql.sql)
do
    psql -U $I2B2_DEMODATA_USER -d i2b2 -w -a -f $x
done
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/expression_concept_demo_insert_data.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/expression_obs_demo_insert_data.sql"

echo
echo "Creating CRC data procedures.."
echo
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_PATIENT_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_PID_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_EID_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_PROVIDER_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_VISIT_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_CONCEPT_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_ENCOUNTERVISIT_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_PATIENT_MAP_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_PATIENT_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_PID_MAP_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_EID_MAP_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_PROVIDER_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/REMOVE_TEMP_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/UPDATE_OBSERVATION_FACT.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/SYNC_CLEAR_CONCEPT_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/SYNC_CLEAR_PROVIDER_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/UPDATE_QUERYINSTANCE_MESSAGE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/CREATE_TEMP_MODIFIER_TABLE.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/INSERT_MODIFIER_FROMTEMP.sql"
psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f "$CRCDATA_DIR/scripts/procedures/postgresql/SYNC_CLEAR_MODIFIER_TABLE.sql"

echo
echo "Importing CRC demo data.."
echo
for x in $(ls $CRCDATA_DIR/demo/scripts/postgresql/*.sql)
do
    psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f $x
done
echo

echo
echo "Importing ACT CRC data.."
echo  
for x in $(ls $CRCDATA_DIR/act/scripts/postgresql/*.sql)
do
    psql -U $I2B2_DEMODATA_USER -d i2b2  -w -a -f $x
done


echo
# ------------- HIVEDATA--------------
echo "Creating Hive data tables.."
echo
psql -U $I2B2_HIVE_USER -d i2b2  -w -a -f "$HIVEDATA_DIR/scripts/create_postgresql_i2b2hive_tables.sql"
echo

echo "Importing Hive demo data.."
echo
psql -U $I2B2_HIVE_USER -d i2b2  -w -a -f "$HIVEDATA_DIR/scripts/work_db_lookup_postgresql_insert_data.sql"
psql -U $I2B2_HIVE_USER -d i2b2  -w -a -f "$HIVEDATA_DIR/scripts/ont_db_lookup_postgresql_insert_data.sql"
psql -U $I2B2_HIVE_USER -d i2b2  -w -a -f "$HIVEDATA_DIR/scripts/crc_db_lookup_postgresql_insert_data.sql"
psql -U $I2B2_HIVE_USER -d i2b2  -w -a -f "$HIVEDATA_DIR/scripts/im_db_lookup_postgresql_insert_data.sql"
echo


# ------------- PMDATA--------------
echo "Creating PM data tables.."
echo
psql -U $I2B2_PM_USER -d i2b2  -w -a -f "$PMDATA_DIR/scripts/create_postgresql_i2b2pm_tables.sql"
echo
echo "Run triggers for PM data.."
echo
psql -U $I2B2_PM_USER -d i2b2  -w -a -f "$PMDATA_DIR/scripts/create_postgresql_triggers.sql"
echo
echo "Importing PM demo data.."
echo
psql -U $I2B2_PM_USER -d i2b2  -w -a -f "$PMDATA_DIR/scripts/demo/pm_access_insert_data.sql"
echo

# ------------- METADATA--------------
echo "Creating Meta data tables.."
echo
psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f "$METADATA_DIR/scripts/create_postgresql_i2b2metadata_tables.sql"
echo
echo "Creating Meta data procedures.."
echo
for x in $(ls $METADATA_DIR/scripts/procedures/postgresql/*.sql)
do
    psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f $x
done

echo
for x in $(ls $METADATA_DIR/demo/scripts/*.sql)
do
    psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f $x
done       
echo

echo "Importing Meta demo data.."
echo
for x in $(ls $METADATA_DIR/demo/scripts/postgresql/*.sql)
do
    psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f $x
done    
echo


echo "Importing ACT Meta data.."
psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f "$METADATA_DIR/act/scripts/postgresql/create_i2b2metadata_tables.sql" #not present 


for x in $(ls $METADATA_DIR/act/scripts/postgresql/*.sql)
do
    psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f $x
done    
echo

psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f "$METADATA_DIR/act/scripts/postgresql/zz_create_i2b2metadata_index.sql"
psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f "$METADATA_DIR/act/scripts/schemes_insert_data.sql"
psql -U $I2B2_METADATA_USER -d i2b2  -w -a -f "$METADATA_DIR/act/scripts/table_access_insert_data.sql"
echo

# ------------- WORKDATA--------------
echo "Creating Work data tables.."
echo
psql -U $I2B2_WORKDATA_USER -d i2b2  -w -a -f "$WORKDATA_DIR/scripts/create_postgresql_i2b2workdata_tables.sql"
echo
echo "Importing Work demo data.."
echo
psql -U $I2B2_WORKDATA_USER -d i2b2  -w -a -f "$WORKDATA_DIR/scripts/workplace_access_demo_insert_data.sql"
echo


echo "Updating db_lookup tables in i2b2hive.."
psql -U $I2B2_HIVE_USER -d i2b2 -w -c "update crc_db_lookup set c_db_fullschema = 'i2b2demodata'"
psql -U $I2B2_HIVE_USER -d i2b2 -w -c "update work_db_lookup set c_db_fullschema = 'i2b2workdata'"
psql -U $I2B2_HIVE_USER -d i2b2 -w -c "update ont_db_lookup set c_db_fullschema = 'i2b2metadata'"
echo 

echo "completed the data load script"
echo "execute the dockerimage.sh script"

sleep 100000000000000