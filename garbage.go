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

func garbage() {
	logger, _ := zap.NewDevelopment()
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colin dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

	fi, err := os.Open("/home/colin/go/src/github.com/coadler/fishyv3/data/trash.json")
	if err != nil {
		logger.Fatal("failed to open item file", zap.Error(err))
	}
	defer fi.Close()

	out, err := ioutil.ReadAll(fi)
	if err != nil {
		logger.Fatal("failed to read item file", zap.Error(err))
	}

	allTrash := new(TrashData)
	err = json.Unmarshal(out, allTrash)
	if err != nil {
		logger.Fatal("failed to unmarshal item file", zap.Error(err))
	}

	for i, e := range allTrash.Regular.Text {
		user := allTrash.Regular.User[i]

		garbage := &models.Garbage{
			Text: e,
			User: user,
		}

		err := garbage.Insert(db)
		if err != nil {
			logger.Error("failed to insert garbage", zap.Error(err))
			continue
		}
	}
}

// TrashData ......
type TrashData struct {
	Regular struct {
		Text []string `json:"text"`
		User []string `json:"user"`
	} `json:"regular"`
	Treasure []struct {
		Name        string `json:"name"`
		Description string `json:"description"`
		Worth       int    `json:"worth"`
	} `json:"treasure"`
}
