package model

import (
	"gorm.io/gorm"
)

type Palabras struct {
	gorm.Model
	Palabra     string    `json:"palabra",gorm:"type:text not null"`
	Frase       string    `json:"frase",gorm:"type:text not null"`
	Significado string    `json:"significado",gorm:"type:text not null"`
	Status      string    `json:"status",gorm:"type:palabra_status"`
	Level       int       `json:"level"`
	Categoria   Categoria `json:"categoria",gorm:"type:text not null"`
	Nintentos   int       `json:"nintentos",gorm:"type:integer not null"`
	Nfallos     int       `json:"nfallos",gorm:"type:integer not null"`
}
type Categoria string

const (
	PREPOSICION     Categoria = "PREPOSICION"
	VERBO_COMPUESTO Categoria = "VERBO_COMPUESTO"
	VERBO           Categoria = "VERBO"
	ADJETIVO        Categoria = "ADJETIVO"
	NOMBRE          Categoria = "NOMBRE"
	ADVERBIO        Categoria = "ADVERBIO"
)
