package db

import (
	"database/sql"
	"log"

	"../config"
	_ "github.com/lib/pq"
)

// Db : var
var Db *sql.DB

func init() {
	Db = connect()
}

func connect() (db *sql.DB) {
	configuration, errConfig := config.LoadConfig()
	if errConfig != nil {
		log.Panicf("error: %s", errConfig.Error())
	}
	db, errorSQL := sql.Open(configuration.DbDriver, configuration.DbConnection)
	if errorSQL != nil {
		log.Fatalf("Error in connection database in %s\n%s", configuration.DbConnection, errorSQL)
	}
	return db
}

// CreateTable : func
func CreateTable(db *sql.DB) {
	db.Exec("CREATE SEQUENCE IF NOT EXISTS domain_seq;")
	db.Exec("CREATE TABLE IF NOT EXISTS domain(id INT PRIMARY KEY DEFAULT nextval('domain_seq'), servers_changed BOOLEAN, ssl_grade STRING(255), previus_ssl_grade STRING(255), logo STRING(255), title STRING(255), is_down BOOLEAN)")
	db.Exec("CREATE SEQUENCE IF NOT EXISTS server_seq;")
	db.Exec("CREATE TABLE IF NOT EXISTS server(id INT PRIMARY KEY DEFAULT nextval('server_seq'), domain INT NOT NULL REFERENCES domain(id), address STRING(255), ssl_grade STRING(255), country STRING(255), owner STRING(255))")
}
