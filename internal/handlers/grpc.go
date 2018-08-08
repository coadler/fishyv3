package fishyv3

import (
	"context"
	"database/sql"
	"time"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/pkg/errors"

	"github.com/coadler/fishyv3/pb"
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

func (s *FishyServerImpl) CheckTime(ctx context.Context, req *pb.CheckTimeRequest) (*pb.CheckTimeResponse, error) {
	var morning, night bool
	now := time.Now().UTC()

	if now.After(Morning1) && now.Before(Morning2) {
		morning = true
	}
	if now.After(Night1) || now.Before(Night2) {
		night = true
	}

	return &pb.CheckTimeResponse{
		Time:    now.Format(time.Kitchen),
		Night:   night,
		Morning: morning,
	}, nil
}
