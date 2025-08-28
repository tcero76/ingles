package repo

import (
	"os"
	"testing"
	"vocabackend/driver"

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
	palabraRepo := PalabraRepository{Db: db}
	result := palabraRepo.GetPalabra("at")
	if result {
		t.Logf("LOG: Resultó y el esperado era %d", rows)
	}
}

func TestFindPalabra(t *testing.T) {
	db := driver.ConnectDB()
	palabraRepo := PalabraRepository{Db: db}
	id := 33
	result := palabraRepo.FindPalabra(id)
	if int(result.ID) != id {
		t.Errorf("ERROR: Resultó %d y el esperado era %d \n", result.ID, id)
	} else {
		t.Logf("LOG: Resultó %d y el esperado era %d\n", result.ID, id)
	}
}
