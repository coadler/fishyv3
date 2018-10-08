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

func fish() {
	logger, _ := zap.NewDevelopment()
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colin dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

	fi, err := os.Open("/home/colin/go/src/github.com/coadler/fishyv3/data/fish.json")
	if err != nil {
		logger.Fatal("failed to open item file", zap.Error(err))
	}
	defer fi.Close()

	out, err := ioutil.ReadAll(fi)
	if err != nil {
		logger.Fatal("failed to read item file", zap.Error(err))
	}

	allFish := new(FishData)
	err = json.Unmarshal(out, allFish)
	if err != nil {
		logger.Fatal("failed to unmarshal item file", zap.Error(err))
	}

	for i, e := range allFish.Location.Lake {
		var (
			time models.Timeofday
		)

		for _, ee := range e.Fish {
			if ee.Time != nil {
				switch *ee.Time {
				case true:
					time = models.TimeofdayNight
				case false:
					time = models.TimeofdayMorning
				}
			} else {
				time = models.TimeofdayBoth
			}

			fish := &models.Fish{
				Low:      ee.Size[0],
				High:     ee.Size[1],
				Time:     time,
				Pun:      ee.Pun,
				Image:    ee.Image,
				Location: models.LocationLake,
				Tier:     i + 1,
				Name:     ee.Name,
			}

			err := fish.Insert(db)
			if err != nil {
				logger.Error("failed to insert fish", zap.Error(err))
				continue
			}
		}
	}
	for i, e := range allFish.Location.River {
		var (
			time models.Timeofday
		)

		for _, ee := range e.Fish {
			if ee.Time != nil {
				switch *ee.Time {
				case true:
					time = models.TimeofdayNight
				case false:
					time = models.TimeofdayMorning
				}
			} else {
				time = models.TimeofdayBoth
			}

			fish := &models.Fish{
				Low:      ee.Size[0],
				High:     ee.Size[1],
				Time:     time,
				Pun:      ee.Pun,
				Image:    ee.Image,
				Location: models.LocationRiver,
				Tier:     i + 1,
				Name:     ee.Name,
			}

			err := fish.Insert(db)
			if err != nil {
				logger.Error("failed to insert fish", zap.Error(err))
				continue
			}
		}
	}
	for i, e := range allFish.Location.Ocean {
		var (
			time models.Timeofday
		)

		for _, ee := range e.Fish {
			if ee.Time != nil {
				switch *ee.Time {
				case true:
					time = models.TimeofdayNight
				case false:
					time = models.TimeofdayMorning
				}
			} else {
				time = models.TimeofdayBoth
			}

			fish := &models.Fish{
				Low:      ee.Size[0],
				High:     ee.Size[1],
				Time:     time,
				Pun:      ee.Pun,
				Image:    ee.Image,
				Location: models.LocationOcean,
				Tier:     i + 1,
				Name:     ee.Name,
			}

			err := fish.Insert(db)
			if err != nil {
				logger.Error("failed to insert fish", zap.Error(err))
				continue
			}
		}
	}
}

// FishData ......
type FishData struct {
	Location struct {
		Lake []struct {
			Fish []struct {
				Name  string `json:"name"`
				Size  []int  `json:"size"`
				Time  *bool  `json:"time"`
				Pun   string `json:"pun"`
				Image string `json:"image"`
			} `json:"fish"`
		} `json:"lake"`
		River []struct {
			Fish []struct {
				Name  string `json:"name"`
				Size  []int  `json:"size"`
				Time  *bool  `json:"time"`
				Pun   string `json:"pun"`
				Image string `json:"image"`
			} `json:"fish"`
		} `json:"river"`
		Ocean []struct {
			Fish []struct {
				Name  string      `json:"name"`
				Size  []int       `json:"size"`
				Time  *bool `json:"time"`
				Pun   string      `json:"pun"`
				Image string      `json:"image"`
			} `json:"fish"`
		} `json:"ocean"`
	} `json:"location"`
	Prices [][]int `json:"prices"`
}
