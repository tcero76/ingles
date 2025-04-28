package driver

import (
	"fmt"
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func logFatal(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func ConnectDB() *gorm.DB {
	db_host := os.Getenv("DB_HOST")
	db_user := os.Getenv("DB_USER")
	db_password := os.Getenv("DB_PASSWORD")
	db_name := os.Getenv("DB_NAME")
	db_port := os.Getenv("DB_PORT")
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=%s",
		db_host, db_user, db_password, db_name, db_port, "disable", "Asia/Shanghai")
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	logFatal(err)
	// db.AutoMigrate(&model.Palabras{})
	return db
}
