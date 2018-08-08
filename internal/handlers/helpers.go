package fishyv3

import (
	"context"
	"database/sql"

	"github.com/pkg/errors"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"github.com/coadler/fishyv3/internal/models"
)

func inTxn(ctx context.Context, db *sql.DB, fn func(txn models.XODB) error) error {
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return status.Error(codes.Internal, errors.Wrap(err, "failed to start transaction").Error())
	}
	defer tx.Rollback()

	err = fn(tx)
	if err != nil {
		return err
	}

	if err := tx.Commit(); err != nil {
		return status.Error(codes.Internal, errors.Wrap(err, "failed to commit transaction").Error())
	}
	return nil
}
