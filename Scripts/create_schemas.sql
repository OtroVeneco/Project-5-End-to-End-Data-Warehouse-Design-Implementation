
/*
  |===============================|
  |        Create Schemas         | 
  |===============================| 
  
 This script create the schemas for the bronze, silver and gold layer.
 If the schemas exists they are dropped and recreated.
 Warning!:
 This script will drop the schemas if it exists and all the tables will be permanently
 deleted.
*/


DROP SCHEMA IF EXISTS bronze;
CREATE SCHEMA bronze;

DROP SCHEMA IF EXISTS silver;
CREATE SCHEMA silver;

DROP SCHEMA IF EXISTS gold;
CREATE SCHEMA gold;