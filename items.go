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

func items() {
	logger, _ := zap.NewDevelopment()
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colin dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

	fi, err := os.Open("/home/colin/go/src/github.com/coadler/fishyv3/data/items.json")
	if err != nil {
		logger.Fatal("failed to open item file", zap.Error(err))
	}
	defer fi.Close()

	out, err := ioutil.ReadAll(fi)
	if err != nil {
		logger.Fatal("failed to read item file", zap.Error(err))
	}

	items := new(ItemData)
	err = json.Unmarshal(out, items)
	if err != nil {
		logger.Fatal("failed to unmarshal item file", zap.Error(err))
	}

	// rip i forgot name in the schema
	for _, e := range items.Bait {
		item := &models.Item{
			Tier:        e.Tier,
			Price:       e.Cost,
			Effect:      e.Effect,
			Description: e.Description,
			Type:        models.ItemtypeBait,
		}

		err := item.Insert(db)
		if err != nil {
			logger.Error("failed to insert item", zap.Error(err))
			continue
		}

	}
	for _, e := range items.Rod {
		item := &models.Item{
			Tier:        e.Tier,
			Price:       e.Cost,
			Effect:      e.Effect,
			Description: e.Description,
			Type:        models.ItemtypeRod,
		}

		err := item.Insert(db)
		if err != nil {
			logger.Error("failed to insert item", zap.Error(err))
			continue
		}

	}
	for _, e := range items.Hook {
		item := &models.Item{
			Tier:        e.Tier,
			Price:       e.Cost,
			Effect:      e.Effect,
			Description: e.Description,
			Type:        models.ItemtypeHook,
		}

		err := item.Insert(db)
		if err != nil {
			logger.Error("failed to insert item", zap.Error(err))
			continue
		}

	}
	for _, e := range items.Vehicle {
		item := &models.Item{
			Tier:        e.Tier,
			Price:       e.Cost,
			Effect:      float64(e.Effect),
			Description: e.Description,
			Type:        models.ItemtypeVehicle,
		}

		err := item.Insert(db)
		if err != nil {
			logger.Error("failed to insert item", zap.Error(err))
			continue
		}

	}
	for _, e := range items.BaitBox {
		item := &models.Item{
			Tier:        e.Tier,
			Price:       e.Cost,
			Effect:      float64(e.Effect),
			Description: e.Description,
			Type:        models.ItemtypeBaitBox,
		}

		err := item.Insert(db)
		if err != nil {
			logger.Error("failed to insert item", zap.Error(err))
			continue
		}

	}
}

// ItemData ........
type ItemData struct {
	Bait []struct {
		Name        string  `json:"name"`
		ID          int     `json:"id"`
		Tier        int     `json:"tier"`
		Cost        int     `json:"cost"`
		Effect      float64 `json:"effect"`
		Description string  `json:"description"`
	} `json:"bait"`
	Rod []struct {
		Name        string  `json:"name"`
		ID          int     `json:"id"`
		Tier        int     `json:"tier"`
		Cost        int     `json:"cost"`
		Effect      float64 `json:"effect"`
		Description string  `json:"description"`
	} `json:"rod"`
	Hook []struct {
		Name        string  `json:"name"`
		ID          int     `json:"id"`
		Tier        int     `json:"tier"`
		Cost        int     `json:"cost"`
		Effect      float64 `json:"effect,omitempty"`
		Description string  `json:"description"`
		Modifier    float64 `json:"modifier,omitempty"`
	} `json:"hook"`
	Vehicle []struct {
		Name        string `json:"name"`
		ID          int    `json:"id"`
		Tier        int    `json:"tier"`
		Cost        int    `json:"cost"`
		Effect      int    `json:"effect"`
		Description string `json:"description"`
	} `json:"vehicle"`
	BaitBox []struct {
		Name        string `json:"name"`
		ID          int    `json:"id"`
		Tier        int    `json:"tier"`
		Cost        int    `json:"cost"`
		Effect      int    `json:"effect"`
		Description string `json:"description"`
	} `json:"bait_box"`
}
