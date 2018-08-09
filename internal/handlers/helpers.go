package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/internal/models"
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
