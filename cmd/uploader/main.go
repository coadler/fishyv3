package main

import (
	"database/sql"

	_ "github.com/lib/pq"

	"go.uber.org/zap"
)

func main() {
	logger, _ := zap.NewDevelopment()
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colinadler dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

}

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
