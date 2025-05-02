package repo

import (
	"fmt"
	"math"
	"time"
	"vocabackend/model"

	"gorm.io/gorm"
)

type PalabraRepository struct{}

func (b PalabraRepository) PutPalabra(db *gorm.DB, palabra model.Palabras) uint {
	result := db.Create(&model.Palabras{
		Palabra:     palabra.Palabra,
		Frase:       palabra.Frase,
		Significado: palabra.Significado,
		Status:      "PENDIENTE",
		Level:       1,
		Categoria:   palabra.Categoria,
	})
	fmt.Println(result)
	return palabra.ID
}

func (b PalabraRepository) GetPalabra(db *gorm.DB, palabraBuscada string) bool {
	palabra := model.Palabras{}
	db.Select("palabra").Where("palabra = ?", palabraBuscada).Find(&palabra)
	fmt.Println(palabra)
	return palabra.Palabra != ""
}

func (b PalabraRepository) GetPalabras(db *gorm.DB, palabras []model.Palabras, page int, rows int) model.Pagination {
	pagination := model.Pagination{Page: page, Limit: rows}
	db.Scopes(paginate(palabras, &pagination, db)).Find(&palabras)
	pagination.Rows = palabras
	return pagination
}

func (b PalabraRepository) GetTestPalabra(db *gorm.DB) (model.Palabras, int, int) {
	palabras := []model.Palabras{}
	db.Find(&palabras).Where("status = ? ", "PENDIENTE")
	size := 0
	for _, p := range palabras {
		if test(&p) {
			size++
		}
	}
	for _, p := range palabras {
		if test(&p) {
			return p, size, len(palabras)
		}
	}
	return model.Palabras{}, size, len(palabras)
}

func test(palabra *model.Palabras) bool {
	var factor time.Duration = 1
	for i := 1; i < palabra.Level; i++ {
		factor *= 2
	}
	return time.Now().After(palabra.UpdatedAt.Add(factor * 24 * time.Hour))
}

func (b PalabraRepository) FindPalabra(db *gorm.DB, id int) model.Palabras {
	palabra := model.Palabras{}
	// fmt.Printf("ID:FINDPALABRA El valor es: %d \n", id)
	db.Where("id", id).First(&palabra)
	return palabra
}

func (b PalabraRepository) UpdatePalabra(db *gorm.DB, palabra *model.Palabras) bool {
	db.Save(palabra)
	return true
}

func paginate(value interface{}, pagination *model.Pagination, db *gorm.DB) func(db *gorm.DB) *gorm.DB {
	var totalRows int64
	db.Model(value).Count(&totalRows)
	pagination.TotalRows = totalRows
	totalPages := int(math.Ceil(float64(totalRows) / float64(pagination.Limit)))
	pagination.TotalPages = totalPages
	return func(db *gorm.DB) *gorm.DB {
		// fmt.Println(pagination.GetOffset())
		return db.Offset(pagination.GetOffset()).Limit(pagination.GetLimit())
	}
}
