package command

import "vocabackend/model"

type PutTestPalabraRes struct {
	Palabra model.Palabras `json:"palabra"`
	Size    int            `json:"size"`
	Total   int            `json:"total"`
}
