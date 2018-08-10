package fishyv3

import (
	"context"
	"time"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

const (
	GatherBaitDuration = 6 * time.Hour
)

func (s *FishyServerImpl) StartGatherBait(ctx context.Context, req *pb.StartGatherBaitRequest) (res *pb.StartGatherBaitResponse, _ error) {
	return res, inTxn(ctx, s.db, func(txn models.XODB) error {
		inv, err := getBaitInv(ctx, txn, req.User, true)
		if err != nil {
			return err
		}

		inv.Gathering = time.Now().Add(GatherBaitDuration)
		return liftDB(inv.Save(txn), "failed to save bait inventory")
	})
}

func (s *FishyServerImpl) CheckGatherBait(ctx context.Context, req *pb.CheckGatherBaitRequest) (res *pb.CheckGatherBaitResponse, _ error) {
	var (
		inv *models.BaitInventory
	)
	err := inTxn(ctx, s.db, func(txn models.XODB) (err error) {
		inv, err = getBaitInv(ctx, txn, req.User, false)
		return err
	})
	if err != nil {
		return res, err
	}

	rem := inv.Gathering.Sub(time.Now())
	return &pb.CheckGatherBaitResponse{
		Remaining: int32(rem.Seconds()),
	}, nil
}
