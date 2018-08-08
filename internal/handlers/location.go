package fishyv3

import (
	"context"
	"database/sql"

	"github.com/pkg/errors"

	"github.com/coadler/fishyv3/internal/converter"
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) GetLocation(ctx context.Context, req *pb.GetLocationRequest) (res *pb.GetLocationResponse, _ error) {
	// this could be cleaned up into a helper since it is going to be repeated a lot
	// we never have a guarantee something exists and can't fail if it doesn't
	locD, err := models.LocationDensityByUser(s.db, req.User)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return res, liftDB(err, "failed to read location density by user")
		}

		locD = &models.LocationDensity{
			User:     req.User,
			Lake:     100,
			River:    100,
			Ocean:    100,
			Location: models.LocationLake,
		}

		err = inTxn(ctx, s.db, func(txn models.XODB) error {
			return liftDB(
				locD.Save(txn),
				"failed to save location",
			)
		})
		if err != nil {
			return res, err
		}

	}

	return &pb.GetLocationResponse{
		Location: converter.FromDBLocation(locD.Location),
	}, nil
}

func (s *FishyServerImpl) SetLocation(ctx context.Context, req *pb.SetLocationRequest) (res *pb.SetLocationResponse, _ error) {
	locD, err := models.LocationDensityByUser(s.db, req.User)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return res, liftDB(err, "failed to read location density by user")
		}

		locD = &models.LocationDensity{
			User:  req.User,
			Lake:  100,
			River: 100,
			Ocean: 100,
		}
	}

	locD.Location = converter.FromPBLocation(req.Location)
	err = inTxn(ctx, s.db, func(txn models.XODB) error {
		return liftDB(
			locD.Save(txn),
			"failed to save location",
		)
	})

	return res, err
}
