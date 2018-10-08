package main

import (
	"database/sql"
	"encoding/json"
	"io/ioutil"
	"os"

	"github.com/coadler/fishyv3/internal/models"
	_ "github.com/lib/pq"
	"go.uber.org/zap"
)

func main() {
	logger, _ := zap.NewDevelopment()
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colin dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

	fi, err := os.Open("/home/colin/go/src/github.com/coadler/fishyv3/data/secretstrings.json")
	if err != nil {
		logger.Fatal("failed to open item file", zap.Error(err))
	}
	defer fi.Close()

	out, err := ioutil.ReadAll(fi)
	if err != nil {
		logger.Fatal("failed to read item file", zap.Error(err))
	}

	allEasterEggs := new(EasterEggData)
	err = json.Unmarshal(out, allEasterEggs)
	if err != nil {
		logger.Fatal("failed to unmarshal easter egg file", zap.Error(err))
	}

	for i, e := range allEasterEggs.Invee {
		secret := models.EasterEggString{
			Data: e,
			Order: i,
			Type: models.EasterEggTypeNoRod,
		}

		err := secret.Insert(db)
		if err != nil {
			logger.Error("failed to insert secret string", zap.Error(err))
			continue
		}
	}
}

// TrashData .....
type EasterEggData struct {
	Invee []string `json:"invee"`
}
