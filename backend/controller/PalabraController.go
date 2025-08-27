package controller

import (
	"encoding/json"
	"net/http"
	"strconv"
	"strings"
	"time"
	"vocabackend/command"
	"vocabackend/model"
	"vocabackend/repo"

	"github.com/gorilla/mux"
	"github.com/labstack/gommon/log"
)

type PalabraController struct {
	PalabraRepo repo.IPalabraRepository
}

func (p PalabraController) PutPalabra() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		log.Info("Inició el Controller")
		palabra := model.Palabras{}
		json.NewDecoder(r.Body).Decode(&palabra)
		if len(palabra.Frase) == 0 || len(palabra.Palabra) == 0 || len(palabra.Significado) == 0 || len(palabra.Categoria) == 0 {
			w.WriteHeader(http.StatusBadRequest)
			w.Header().Set("Content-Type", "application/json")
			res := command.PutPalabraRes{Message: "Datos errados"}
			json.NewEncoder(w).Encode(res)
			return
		}
		if p.PalabraRepo.GetPalabra(strings.ToLower(palabra.Palabra)) {
			w.WriteHeader(http.StatusBadRequest)
			w.Header().Set("Content-Type", "application/json")
			res := command.PutPalabraRes{Message: "Palabra duplicada"}
			json.NewEncoder(w).Encode(res)
			return
		}
		log.Debug("PALABRA: encontrada es: ", palabra)
		p.PalabraRepo.PutPalabra(palabra)
		w.WriteHeader(http.StatusOK)
		res := command.PutPalabraRes{Message: "Palabra Guardada"}
		json.NewEncoder(w).Encode(res)
	}
}

func (p PalabraController) GetPalabras() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		log.Info("INICIO: GetPalabras")
		vars := mux.Vars(r)
		page, _ := strconv.Atoi(vars["page"])
		rows, _ := strconv.Atoi(vars["rows"])
		palabras := []model.Palabras{}
		pagination := p.PalabraRepo.GetPalabras(palabras, page, rows)
		log.Debug("PALABRAS: encontradas son: ", pagination)
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(pagination)
	}
}

func (p PalabraController) PutTestPalabra() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		log.Info("INICIO: PutTestPalabra")
		testUpdate := command.CommandTestUpdate{}
		json.NewDecoder(r.Body).Decode(&testUpdate)
		id := testUpdate.Id
		log.Debug("ID: El valor es: ", id)
		palabra := p.PalabraRepo.FindPalabra(id)
		palabra.Nintentos = palabra.Nintentos + 1
		palabra.UpdatedAt = time.Now()
		log.Debug("PALABRA: La palabra es: ", palabra.Palabra)
		if testUpdate.Resultado == 0 {
			palabra.Level = 1
			palabra.Nfallos = palabra.Nfallos + 1
		} else {
			palabra.Level = palabra.Level + 1
			if palabra.Level > 6 {
				palabra.Status = "COMPLETADO"
			}
		}
		p.PalabraRepo.UpdatePalabra(&palabra)
		palabraRespuesta, n, N := p.PalabraRepo.GetTestPalabra()
		log.Debug("PALABRA RESPUESTA: La palabra es: ", palabraRespuesta.Palabra)
		resp := command.PutTestPalabraRes{palabraRespuesta, n, N}
		json.NewEncoder(w).Encode(&resp)
	}
}

func (p PalabraController) GetTestPalabra() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		log.Info("INICIO: GetTestPalabra")
		palabraRespuesta, n, N := p.PalabraRepo.GetTestPalabra()
		log.Info("PALABRA RESPUESTA: La palabra es: ", palabraRespuesta.Palabra)
		resp := command.PutTestPalabraRes{palabraRespuesta, n, N}
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(&resp)
	}
}
