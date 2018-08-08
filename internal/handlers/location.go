package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/internal/converter"
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *FishyServerImpl) GetLocation(ctx context.Context, req *pb.GetLocationRequest) (*pb.GetLocationResponse, error) {
	// this could be cleaned up into a helper since it is going to be repeated a lot
	// we never have a guarantee something exists and can't fail if it doesn't
	locD, err := models.LocationDensityByUser(s.db, req.User)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return nil, status.Errorf(codes.Internal, errors.Wrap(err, "failed to scan location density by user").Error())
		}

		tx, err := s.db.BeginTx(ctx, nil)
		if err != nil {
			return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to start transaction").Error())
		}
		defer tx.Rollback()

		locD = &models.LocationDensity{
			User:     req.User,
			Lake:     100,
			River:    100,
			Ocean:    100,
			Location: models.LocationLake,
		}

		if err := locD.Save(tx); err != nil {
			return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to save location density").Error())
		}

		if err := tx.Commit(); err != nil {
			return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to commit transaction").Error())
		}
	}

	return &pb.GetLocationResponse{
		Location: converter.FromDBLocation(locD.Location),
	}, nil
}

func (s *FishyServerImpl) SetLocation(ctx context.Context, req *pb.SetLocationRequest) (*pb.SetLocationResponse, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to start transaction").Error())
	}
	defer tx.Rollback()

	locD, err := models.LocationDensityByUser(s.db, req.User)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return nil, status.Errorf(codes.Internal, errors.Wrap(err, "failed to scan location density by user").Error())
		}

		locD = &models.LocationDensity{
			User:     req.User,
			Lake:     100,
			River:    100,
			Ocean:    100,
			Location: models.LocationLake,
		}
	}

	locD.Location = converter.FromPBLocation(req.Location)
	if err := locD.Save(tx); err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to save location density").Error())
	}

	if err := tx.Commit(); err != nil {
		return nil, status.Error(codes.Internal, errors.Wrap(err, "failed to commit transaction").Error())
	}

	return &pb.SetLocationResponse{}, nil
}
