package fishyv3

import (
	"context"
	"database/sql"
	"time"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"github.com/coadler/fishyv3/internal/converter"
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
)

// BuyBait handles the GRPC route for buying bait.
func (s *FishyServerImpl) BuyBait(ctx context.Context, req *pb.BuyBaitRequest) (*pb.BuyBaitResponse, error) {
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		tier, err := userTier(txn, req.User)
		if err != nil {
			return liftDB(err, "failed to get user tier")
		}

		if req.Tier > pb.BaitTier(tier) {
			return status.Error(codes.FailedPrecondition, "")
		}

		inv, err := models.BaitInventoryByUser(txn, req.User)
		if err != nil {
			return liftDB(err, "failed to get bait inventory")
		}

		addBaitToPBTier(inv, req.Tier, int(req.Amount))
		return liftDB(inv.Upsert(txn), "failed to upsert bait inventory")
	})

	return &pb.BuyBaitResponse{}, err
}

// GetBaitTier handles the GRPC route for getting a user's current bait tier.
func (s *FishyServerImpl) GetBaitTier(ctx context.Context, req *pb.GetBaitTierRequest) (*pb.GetBaitTierResponse, error) {
	var tier pb.BaitTier
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		inv, err := getBaitInv(ctx, txn, req.User, false)
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
func (s *FishyServerImpl) SetBaitTier(ctx context.Context, req *pb.SetBaitTierRequest) (*pb.SetBaitTierResponse, error) {
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		inv, err := getBaitInv(ctx, s.db, req.User, false)
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

func getBaitInv(ctx context.Context, db models.XODB, user string, failGathering bool) (inv *models.BaitInventory, err error) {
	inv, err = models.BaitInventoryByUser(db, user)
	if err != nil {
		if errors.Cause(err) != sql.ErrNoRows {
			return inv, liftDB(err, "failed to get bait inventory")
		}

		if err := (&models.OwnedItem{
			User: user,
			Item: models.ItemtypeBait,
			Tier: converter.FromPBBaitTier(pb.BaitTier_T1),
		}).Save(db); err != nil {
			return inv, liftDB(err, "failed to insert owned item")
		}

		*inv = models.BaitInventory{
			User:    user,
			Current: 1,
		}
	}

	// exit if we're currently gathering and caller wants to error
	if time.Now().Before(inv.Gathering) {
		if failGathering {
			return inv, ErrGatheringBait
		}
	} else {
		// after gathering timeout, fulfill rewards
		if !inv.Gathering.IsZero() {
			inv.Gathering = time.Time{}
			// not safe
			addBaitToDBTier(inv, inv.Current, 10)
		}
	}

	return inv, liftDB(
		inv.Save(db),
		"failed to save bait inventory",
	)
}

func addBaitToPBTier(inv *models.BaitInventory, tier pb.BaitTier, amt int) {
	switch tier {
	case pb.BaitTier_T1:
		inv.Tier1 += amt
	case pb.BaitTier_T2:
		inv.Tier2 += amt
	case pb.BaitTier_T3:
		inv.Tier3 += amt
	case pb.BaitTier_T4:
		inv.Tier4 += amt
	case pb.BaitTier_T5:
		inv.Tier5 += amt
	}
}

func addBaitToDBTier(inv *models.BaitInventory, tier, amt int) {
	switch tier {
	case 1:
		inv.Tier1 += amt
	case 2:
		inv.Tier2 += amt
	case 3:
		inv.Tier3 += amt
	case 4:
		inv.Tier4 += amt
	case 5:
		inv.Tier5 += amt
	}
}
