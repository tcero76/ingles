package controller

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"
	"vocabackend/command"
	"vocabackend/model"
	"vocabackend/repo"

	"github.com/gorilla/mux"

	"gorm.io/gorm"
)

type PalabraController struct{}

func (p PalabraController) PutPalabra(db *gorm.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		palabra := model.Palabras{}
		json.NewDecoder(r.Body).Decode(&palabra)
		if len(palabra.Frase) == 0 || len(palabra.Palabra) == 0 || len(palabra.Significado) == 0 || len(palabra.Categoria) == 0 {
			w.WriteHeader(http.StatusBadRequest)
			w.Header().Set("Content-Type", "application/json")
			res := command.PutPalabraRes{Message: "Datos errados"}
			json.NewEncoder(w).Encode(res)
			return
		}
		if p.getPalabra(palabra.Palabra, db) {
			w.WriteHeader(http.StatusBadRequest)
			w.Header().Set("Content-Type", "application/json")
			res := command.PutPalabraRes{Message: "Palabra duplicada"}
			json.NewEncoder(w).Encode(res)
			return
		}
		palabraRepo := repo.PalabraRepository{}
		fmt.Println(palabra)
		palabraRepo.PutPalabra(db, palabra)
		w.WriteHeader(http.StatusOK)
		res := command.PutPalabraRes{Message: "Palabra Guardada"}
		json.NewEncoder(w).Encode(res)
	}
}

func (p PalabraController) getPalabra(palabra string, db *gorm.DB) bool {
	fmt.Println("GETPALABRA: Inició el Controller")
	palabraRepo := repo.PalabraRepository{}
	return palabraRepo.GetPalabra(db, strings.ToLower(palabra))
}

func (p PalabraController) GetPalabras(db *gorm.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("GETPALABRAS: Inició el Controller")
		vars := mux.Vars(r)
		page, _ := strconv.Atoi(vars["page"])
		rows, _ := strconv.Atoi(vars["rows"])
		palabras := []model.Palabras{}
		palabraRepo := repo.PalabraRepository{}
		pagination := palabraRepo.GetPalabras(db, palabras, page, rows)
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(pagination)
	}
}

func (p PalabraController) PutTestPalabra(db *gorm.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("PUTTESTPALABRA: Inicio")
		testUpdate := command.CommandTestUpdate{}
		json.NewDecoder(r.Body).Decode(&testUpdate)
		palabraRepo := repo.PalabraRepository{}
		id := testUpdate.Id
		fmt.Printf("ID: El valor es: %d \n", id)
		palabra := palabraRepo.FindPalabra(db, id)
		palabra.Nintentos = palabra.Nintentos + 1
		palabra.UpdatedAt = time.Now()
		fmt.Printf("PALABRA: La palabra es: %s \n", palabra.Palabra)
		if testUpdate.Resultado == 0 {
			palabra.Level = 1
			palabra.Nfallos = palabra.Nfallos + 1
		} else {
			palabra.Level = palabra.Level + 1
			if palabra.Level > 6 {
				palabra.Status = "COMPLETADO"
			}
		}
		palabraRepo.UpdatePalabra(db, &palabra)
		palabraRespuesta, n, N := repo.PalabraRepository{}.GetTestPalabra(db)
		resp := command.PutTestPalabraRes{palabraRespuesta, n, N}
		json.NewEncoder(w).Encode(&resp)
	}
}

func (p PalabraController) GetTestPalabra(db *gorm.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("GETTESPALABRA: Inicio")
		palabraRespuesta, n, N := repo.PalabraRepository{}.GetTestPalabra(db)
		resp := command.PutTestPalabraRes{palabraRespuesta, n, N}
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(&resp)
	}
}
