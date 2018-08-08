package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *FishyServerImpl) Blacklist(ctx context.Context, req *pb.BlacklistRequest) (*pb.BlacklistResponse, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to start transaction").Error())
	}
	defer tx.Rollback()

	if err := (&models.Blacklist{
		User: req.User,
	}).Upsert(tx); err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to save blacklist").Error())
	}

	if err := tx.Commit(); err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to commit transaction").Error())
	}

	return &pb.BlacklistResponse{}, nil
}

func (s *FishyServerImpl) Unblacklist(ctx context.Context, req *pb.UnblacklistRequest) (res *pb.UnblacklistResponse, err error) {
	b, err := models.BlacklistByUser(s.db, req.User)
	if err != nil {
		return res, status.Error(codes.Internal, err.Error())
	}

	if err = inTxn(ctx, s.db, func(txn models.XODB) error {
		if err := b.Delete(txn); err != nil {
			return status.Error(codes.Internal, err.Error())
		}
		return nil
	}); err != nil {
		return res, err
	}

	return res, nil
}
