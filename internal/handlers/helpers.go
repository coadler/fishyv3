package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/pkg/errors"
)

func inTxn(ctx context.Context, db *sql.DB, fn func(txn models.XODB) error) error {
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return liftDB(err, "failed to start transaction")
	}
	defer tx.Rollback()

	err = fn(tx)
	if err != nil {
		return err
	}

	if err := tx.Commit(); err != nil {
		return liftDB(err, "failed to commit transaction")
	}
	return nil
}

func userTier(db models.XODB, user string) (int, error) {
	ranking, err := models.GlobalRankingByUser(db, user)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return 0, err
		}

		ranking = &models.GlobalRanking{
			User: user,
		}

		err := ranking.Insert(db)
		if err != nil {
			if err != nil {
				return 0, err
			}
		}
	}

	tiers, err := models.GetAllTiers(db)
	if err != nil {
		return 0, err
	}

	var tier int
	for _, e := range tiers {
		if ranking.Score >= e.Required {
			tier = e.Tier
		}
	}

	if tier == 0 {
		return 0, errors.New("could not find tier")
	}

	return tier, nil
}

func globalLeaderboardCount(db models.XODB) (int, error) {
	c, err := models.GetGlobalLeaderboardCounts(db)
	if err != nil {
		return 0, liftDB(err, "failed to read global leaderboard count")
	}

	return int(c[0].Count), nil
}

func guildLeaderboardCount(db models.XODB) (int, error) {
	c, err := models.GetGuildLeaderboardCounts(db)
	if err != nil {
		return 0, liftDB(err, "failed to read guild leaderboard count")
	}

	return int(c[0].Count), nil
}
