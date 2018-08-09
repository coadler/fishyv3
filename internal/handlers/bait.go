package fishyv3

import (
	"context"
	"database/sql"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"github.com/coadler/fishyv3/internal/converter"
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
)

// BuyBait handles the GRPC route for buying bait.
func (s *FishyServerImpl) BuyBait(ctx context.Context, req *pb.BuyBaitRequest) (*pb.BuyBaitResponse, error) {
	return &pb.BuyBaitResponse{}, nil
}

// GetBaitTier handles the GRPC route for getting a user's current bait tier.
func (s *FishyServerImpl) GetBaitTier(ctx context.Context, req *pb.GetBaitTierRequest) (res *pb.GetBaitTierResponse, _ error) {
	var tier pb.BaitTier
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		inv, err := getBaitInv(ctx, req.User, txn)
		if err != nil {
			return err
		}

		tier = converter.FromDBBaitTier(inv.Current)
		return nil
	})

	return &pb.GetBaitTierResponse{
		Tier: tier,
	}, err
}

// SetBaitTier handles the GRPC route for setting a user's current bait tier.
func (s *FishyServerImpl) SetBaitTier(ctx context.Context, req *pb.SetBaitTierRequest) (res *pb.SetBaitTierResponse, _ error) {
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		inv, err := getBaitInv(ctx, req.User, s.db)
		if err != nil {
			return err
		}

		if _, err := models.OwnedItemByUserItemTier(
			txn,
			req.User,
			converter.FromPBItem(pb.Item_BAIT),
			converter.FromPBBaitTier(req.Tier),
		); err != nil {
			if errors.Cause(err) == sql.ErrNoRows {
				return status.Error(codes.FailedPrecondition, "user does not own bait tier")
			}

			return liftDB(err, "failed to get owned item")
		}

		if converter.FromDBBaitTier(inv.Current) == req.Tier {
			// nothing to do
			return nil
		}

		inv.Current = converter.FromPBBaitTier(req.Tier)
		return liftDB(inv.Save(txn), "failed to update current bait")
	})

	return &pb.SetBaitTierResponse{}, err
}

func getBaitInv(ctx context.Context, user string, db models.XODB) (inv *models.BaitInventory, err error) {
	inv, err = models.BaitInventoryByUser(db, user)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return inv, liftDB(err, "failed to get bait inventory")
		}

		if err := (&models.OwnedItem{
			User: user,
			Item: models.ItemBait,
			Tier: converter.FromPBBaitTier(pb.BaitTier_T1),
		}).Save(db); err != nil {
			return inv, liftDB(err, "failed to insert owned item")
		}

		*inv = models.BaitInventory{
			User:    user,
			Current: 1,
		}
		return inv, liftDB(
			inv.Save(db),
			"failed to save bait inventory",
		)
	}

	return
}
