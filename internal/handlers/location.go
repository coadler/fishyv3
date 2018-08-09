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
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		locD, err := getLocDen(ctx, req.User, txn)
		if err != nil {
			return err
		}

		res.Location = converter.FromDBLocation(locD.Location)
		return nil
	})

	return res, err
}

func (s *FishyServerImpl) SetLocation(ctx context.Context, req *pb.SetLocationRequest) (res *pb.SetLocationResponse, _ error) {
	return res, inTxn(ctx, s.db, func(txn models.XODB) error {
		locD, err := getLocDen(ctx, req.User, txn)
		if err != nil {
			return err
		}

		locD.Location = converter.FromPBLocation(req.Location)
		return liftDB(err, "failed to save location density")
	})
}

func getLocDen(ctx context.Context, user string, db models.XODB) (*models.LocationDensity, error) {
	locDen, err := models.LocationDensityByUser(db, user)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return locDen, liftDB(err, "failed to read location density by user")
		}

		*locDen = models.LocationDensity{
			User:  user,
			Lake:  100,
			River: 100,
			Ocean: 100,
		}

		return locDen, liftDB(locDen.Save(db), "failed to save location density")
	}

	return locDen, nil
}
