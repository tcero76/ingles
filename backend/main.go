package main

import (
	"log"
	"net/http"
	"time"

	"vocabackend/controller"
	"vocabackend/driver"

	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

var db *gorm.DB

func logRequest(r *http.Request) {
	log.Printf("Request: %s %s", r.Method, r.URL.Path)
}

func main() {
	r := mux.NewRouter()
	db = driver.ConnectDB()

	palabraController := controller.PalabraController{}

	r.HandleFunc("/", palabraController.PutPalabra(db)).Methods("PUT")
	r.HandleFunc("/palabras", palabraController.GetPalabras(db)).Methods("GET").Queries("rows", "{rows}").Queries("page", "{page}")
	r.HandleFunc("/palabras", palabraController.GetPalabra(db)).Methods("GET").Queries("palabra", "{palabra}")
	r.HandleFunc("/test/palabras", palabraController.PutTestPalabra(db)).Methods("PUT")
	r.HandleFunc("/test/palabras", palabraController.GetTestPalabra(db)).Methods("GET")

	http.Handle("/", r)
	srv := &http.Server{
		Handler:      r,
		Addr:         "0.0.0.0:8000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}
