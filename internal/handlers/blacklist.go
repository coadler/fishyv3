package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) Blacklist(ctx context.Context, req *pb.BlacklistRequest) (*pb.BlacklistResponse, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, liftDB(err, "failed to start transaction")
	}
	defer tx.Rollback()

	if err := (&models.Blacklist{
		User: req.User,
	}).Upsert(tx); err != nil {
		return nil, liftDB(err, "failed to save blacklist")
	}

	if err := tx.Commit(); err != nil {
		return nil, liftDB(err, "failed to commit transaction")
	}

	return &pb.BlacklistResponse{}, nil
}

func (s *FishyServerImpl) Unblacklist(ctx context.Context, req *pb.UnblacklistRequest) (res *pb.UnblacklistResponse, err error) {
	b, err := models.BlacklistByUser(s.db, req.User)
	if err != nil {
		return res, liftDB(err, "failed to read blacklist by user")
	}

	if err = inTxn(ctx, s.db, func(txn models.XODB) error {
		if err := b.Delete(txn); err != nil {
			return liftDB(err, "failed to delete blacklist")
		}
		return nil
	}); err != nil {
		return res, err
	}

	return res, nil
}
