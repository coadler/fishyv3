package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
)

// BuyBait handles the GRPC route for buying bait.
func (s *FishyServerImpl) BuyBait(ctx context.Context, req *pb.BuyBaitRequest) (*pb.BuyBaitResponse, error) {
	return &pb.BuyBaitResponse{}, nil
}

// GetBaitTier handles the GRPC route for getting a user's current bait tier.
func (s *FishyServerImpl) GetBaitTier(ctx context.Context, req *pb.GetBaitTierRequest) (*pb.GetBaitTierResponse, error) {
	// inv, err := models.BaitInventoryByUser(s.db, req.User)

	return &pb.GetBaitTierResponse{
		Tier: pb.BaitTier_T1,
	}, nil
}

// SetBaitTier handles the GRPC route for setting a user's current bait tier.
func (s *FishyServerImpl) SetBaitTier(ctx context.Context, req *pb.SetBaitTierRequest) (*pb.SetBaitTierResponse, error) {
	return &pb.SetBaitTierResponse{}, nil
}

func (s *FishyServerImpl) handleBaitInvErr(ctx context.Context, user string, inv *models.BaitInventory, err error) error {
	if err == nil {
		return nil
	}

	if errors.Cause(err) != sql.ErrNoRows {
		return liftDB(err, "failed to get bait inventory")
	}

	return inTxn(ctx, s.db, func(txn models.XODB) error {
		*inv = models.BaitInventory{
			User: user,
		}
		return liftDB(
			inv.Save(s.db),
			"failed to save bait inventory",
		)
	})
}
