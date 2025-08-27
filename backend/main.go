package main

import (
	"log"
	"net/http"
	"time"

	"vocabackend/controller"
	"vocabackend/driver"
	"vocabackend/repo"

	"github.com/gorilla/mux"
	glog "github.com/labstack/gommon/log"
	"gorm.io/gorm"
)

var db *gorm.DB

func logRequest(r *http.Request) {
	log.Printf("Request: %s %s", r.Method, r.URL.Path)
}

func main() {
	r := mux.NewRouter()
	db = driver.ConnectDB()
	glog.SetLevel(glog.INFO)

	palabraRepo := &repo.PalabraRepository{Db: db}

	palabraController := controller.PalabraController{PalabraRepo: palabraRepo}

	r.HandleFunc("/", palabraController.PutPalabra()).Methods("PUT")
	r.HandleFunc("/palabras", palabraController.GetPalabras()).Methods("GET").Queries("rows", "{rows}").Queries("page", "{page}")
	r.HandleFunc("/test/palabras", palabraController.PutTestPalabra()).Methods("PUT")
	r.HandleFunc("/test/palabras", palabraController.GetTestPalabra()).Methods("GET")

	http.Handle("/", r)
	srv := &http.Server{
		Handler:      r,
		Addr:         "0.0.0.0:8000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}
