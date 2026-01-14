/*
 |==============================|
 | Create database and schemas  |
 |==============================|
 
 This script create a new database after checking if it already exists.
 If the database exists, it is dropped and recreated.
 WARNING!:
 Running this script will drop the entire database if it exists.
 All the database will be permanently deleted.
*/

DROP DATABASE IF EXISTS project1;
CREATE DATABASE project1;


