package repo

import (
	"math"
	"time"
	"vocabackend/model"

	"github.com/labstack/gommon/log"
	"gorm.io/gorm"
)

type IPalabraRepository interface {
	PutPalabra(palabra model.Palabras) uint
	GetPalabra(palabraBuscada string) bool
	GetPalabras(palabras []model.Palabras, page int, rows int) model.Pagination
	GetTestPalabra() (model.Palabras, int, int)
	FindPalabra(id int) model.Palabras
	UpdatePalabra(palabra *model.Palabras) bool
}

type PalabraRepository struct {
	Db *gorm.DB
}

func (b PalabraRepository) PutPalabra(palabra model.Palabras) uint {
	result := b.Db.Create(&model.Palabras{
		Palabra:     palabra.Palabra,
		Frase:       palabra.Frase,
		Significado: palabra.Significado,
		Status:      "PENDIENTE",
		Level:       1,
		Categoria:   palabra.Categoria,
	})
	log.Debug("PALABRA: creada es: ", result)
	return palabra.ID
}

func (b PalabraRepository) GetPalabra(palabraBuscada string) bool {
	palabra := model.Palabras{}
	b.Db.Select("palabra").Where("palabra = ?", palabraBuscada).Find(&palabra)
	log.Info("PALABRA: encontrada es: ", palabra)
	return palabra.Palabra != ""
}

func (b PalabraRepository) GetPalabras(palabras []model.Palabras, page int, rows int) model.Pagination {
	pagination := model.Pagination{Page: page, Limit: rows}
	b.Db.Scopes(paginate(palabras, &pagination, b.Db)).Find(&palabras)
	log.Debug("PALABRAS: encontradas son: ", palabras)
	pagination.Rows = palabras
	return pagination
}

func (b PalabraRepository) GetTestPalabra() (model.Palabras, int, int) {
	palabras := []model.Palabras{}
	b.Db.Find(&palabras).Where("status = ? ", "PENDIENTE")
	log.Debug("PALABRAS: encontradas son: ", palabras)
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

func (b PalabraRepository) FindPalabra(id int) model.Palabras {
	palabra := model.Palabras{}
	b.Db.Where("id", id).First(&palabra)
	log.Debug("PALABRA: encontrada es: ", palabra)
	return palabra
}

func (b PalabraRepository) UpdatePalabra(palabra *model.Palabras) bool {
	b.Db.Save(palabra)
	log.Debug("PALABRA: actualizada es: ", palabra)
	return true
}

func paginate(value interface{}, pagination *model.Pagination, db *gorm.DB) func(db *gorm.DB) *gorm.DB {
	var totalRows int64
	db.Model(value).Count(&totalRows)
	pagination.TotalRows = totalRows
	totalPages := int(math.Ceil(float64(totalRows) / float64(pagination.Limit)))
	pagination.TotalPages = totalPages
	return func(db *gorm.DB) *gorm.DB {
		return db.Offset(pagination.GetOffset()).Limit(pagination.GetLimit())
	}
}
