package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/internal/converter"
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) Inventory(ctx context.Context, req *pb.InventoryRequest) (*pb.InventoryResponse, error) {
	return &pb.InventoryResponse{
		Items: &pb.UserItems{
			Bait: &pb.UserItem{
				Current: 3,
				Owned:   []int32{1, 2, 3},
			},
			Rod: &pb.UserItem{
				Current: 3,
				Owned:   []int32{1, 2, 3},
			},
			Hook: &pb.UserItem{
				Current: 3,
				Owned:   []int32{1, 2, 3},
			},
			Vehicle: &pb.UserItem{
				Current: 3,
				Owned:   []int32{1, 2, 3},
			},
			BaitBox: &pb.UserItem{
				Current: 3,
				Owned:   []int32{1, 2, 3},
			},
		},
		Fish: &pb.FishInventory{
			Fish:        11,
			Legendaries: 0,
			Garbage:     55,
			Worth:       523,
		},
		MaxFish:  100,
		MaxBait:  100,
		UserTier: 4,
	}, nil
}

func (s *FishyServerImpl) BuyItem(ctx context.Context, req *pb.BuyItemRequest) (*pb.BuyItemResponse, error) {
	return &pb.BuyItemResponse{}, nil
}

func (s *FishyServerImpl) SellFish(ctx context.Context, req *pb.SellFishRequest) (*pb.SellFishResponse, error) {
	return &pb.SellFishResponse{
		Worth: 412,
	}, nil
}

func (s *FishyServerImpl) GetBaitInventory(ctx context.Context, req *pb.GetBaitInventoryRequest) (*pb.GetBaitInventoryResponse, error) {
	var inv *models.BaitInventory
	err := inTxn(ctx, s.db, func(txn models.XODB) (err error) {
		inv, err = getBaitInv(ctx, txn, req.User, true)
		return err
	})

	return &pb.GetBaitInventoryResponse{
		MaxBait:      100,
		CurrentCount: 33,
		Bait:         converter.FromDBBaitInventory(inv),
		CurrentTier:  int32(inv.Current),
		BaitboxTier:  3,
	}, err
}
