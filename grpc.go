package fishyv3

import (
	"context"
	"time"

	"github.com/ThyLeader/fishyv3/pb"
)

type FishyServer struct{}

var _ pb.FishyServer = &FishyServer{}

func (s *FishyServer) Fishy(c context.Context, req *pb.FishRequest) (*pb.FishResponse, error) {
	return &pb.FishResponse{}, nil
}

func (s *FishyServer) Inventory(c context.Context, req *pb.InventoryRequest) (*pb.InventoryResponse, error) {
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

func (s *FishyServer) GetLocation(c context.Context, req *pb.GetLocationRequest) (*pb.GetLocationResponse, error) {
	return &pb.GetLocationResponse{
		Location: pb.Location_LAKE,
	}, nil
}

func (s *FishyServer) SetLocation(c context.Context, req *pb.SetLocationRequest) (*pb.SetLocationResponse, error) {
	return &pb.SetLocationResponse{}, nil
}

func (s *FishyServer) BuyItem(c context.Context, req *pb.BuyItemRequest) (*pb.BuyItemResponse, error) {
	return &pb.BuyItemResponse{}, nil
}

func (s *FishyServer) Blacklist(c context.Context, req *pb.BlacklistRequest) (*pb.BlacklistResponse, error) {
	return &pb.BlacklistResponse{}, nil
}

func (s *FishyServer) Unblacklist(c context.Context, req *pb.UnblacklistRequest) (*pb.UnblacklistResponse, error) {
	return &pb.UnblacklistResponse{}, nil
}

func (s *FishyServer) StartGatherBait(c context.Context, req *pb.StartGatherBaitRequest) (*pb.StartGatherBaitResponse, error) {
	return &pb.StartGatherBaitResponse{}, nil
}

func (s *FishyServer) CheckGatherBait(c context.Context, req *pb.CheckGatherBaitRequest) (*pb.CheckGatherBaitResponse, error) {
	return &pb.CheckGatherBaitResponse{
		Remaining: 9254,
	}, nil
}

func (s *FishyServer) Leaderboard(c context.Context, req *pb.LeaderboardRequest) (*pb.LeaderboardResponse, error) {
	return &pb.LeaderboardResponse{
		Users: []*pb.LeaderboardUser{
			{
				User:  "127092809625763840",
				Score: 193,
			},
			{
				User:  "84186862997995520",
				Score: 185,
			},
			{
				User:  "298423262059429888",
				Score: 143,
			},
			{
				User:  "461425310760435712",
				Score: 123,
			},
			{
				User:  "140631601594892288",
				Score: 50,
			},
		},
	}, nil
}

func (s *FishyServer) CheckTime(c context.Context, req *pb.CheckTimeRequest) (*pb.CheckTimeResponse, error) {
	var morning, night bool
	now := time.Now()

	if now.After(Morning1) && now.Before(Morning2) {
		morning = true
	}
	if now.After(Night1) || now.Before(Night2) {
		night = true
	}

	return &pb.CheckTimeResponse{
		Time:    now.Format(time.Kitchen),
		Night:   night,
		Morning: morning,
	}, nil
}

func (s *FishyServer) GetBaitInventory(c context.Context, req *pb.GetBaitInventoryRequest) (*pb.GetBaitInventoryResponse, error) {
	return &pb.GetBaitInventoryResponse{
		MaxBait:      100,
		CurrentCount: 33,
		Bait: &pb.BaitInventory{
			T1: 13,
			T2: 5,
			T3: 5,
			T4: 5,
			T5: 5,
		},
		CurrentTier: 1,
		BaitboxTier: 3,
	}, nil
}

func (s *FishyServer) BuyBait(c context.Context, req *pb.BuyBaitRequest) (*pb.BuyBaitResponse, error) {
	return &pb.BuyBaitResponse{}, nil
}

func (s *FishyServer) GetBaitTier(c context.Context, req *pb.GetBaitTierRequest) (*pb.GetBaitTierResponse, error) {
	return &pb.GetBaitTierResponse{
		Tier: pb.BaitTier_T1,
	}, nil
}

func (s *FishyServer) SetBaitTier(c context.Context, req *pb.SetBaitTierRequest) (*pb.SetBaitTierResponse, error) {
	return &pb.SetBaitTierResponse{}, nil
}

func (s *FishyServer) SellFish(c context.Context, req *pb.SellFishRequest) (*pb.SellFishResponse, error) {
	return &pb.SellFishResponse{
		Worth: 412,
	}, nil
}
