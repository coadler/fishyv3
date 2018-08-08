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
