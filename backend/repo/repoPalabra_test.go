package repo

import (
	"fmt"
	"os"
	"testing"
	"vocabackend/driver"
	"vocabackend/model"

	"github.com/joho/godotenv"
)

func TestMain(m *testing.M) {
	err := godotenv.Load()
	if err != nil {
		panic("Error cargando archivo .env")
	}
	os.Exit(m.Run())
}

func TestGetPalabra(t *testing.T) {
	db := driver.ConnectDB()
	var rows = 1
	palabras := []model.Palabras{}
	service := PalabraRepository{}
	result := service.GetPalabra(db, palabras, 1, rows)
	fmt.Println("El valor de Rows, es: ")
	fmt.Println(result.Rows)
	if len(result.Rows.([]model.Palabras)) != rows {
		t.Errorf("ERROR: Resultó %d y el esperado era %d", len(result.Rows.([]model.Palabras)), rows)
	} else {
		t.Logf("LOG: Resultó %d y el esperado era %d", len(result.Rows.([]model.Palabras)), rows)
	}
}

func TestFindPalabra(t *testing.T) {
	db := driver.ConnectDB()
	palabraRepo := PalabraRepository{}
	id := 33
	result := palabraRepo.FindPalabra(db, id)
	if int(result.ID) != id {
		t.Errorf("ERROR: Resultó %d y el esperado era %d \n", result.ID, id)
	} else {
		t.Logf("LOG: Resultó %d y el esperado era %d\n", result.ID, id)
	}
}
