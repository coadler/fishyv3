package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) BuyBait(ctx context.Context, req *pb.BuyBaitRequest) (*pb.BuyBaitResponse, error) {
	return &pb.BuyBaitResponse{}, nil
}

func (s *FishyServerImpl) GetBaitTier(ctx context.Context, req *pb.GetBaitTierRequest) (*pb.GetBaitTierResponse, error) {
	return &pb.GetBaitTierResponse{
		Tier: pb.BaitTier_T1,
	}, nil
}

func (s *FishyServerImpl) SetBaitTier(ctx context.Context, req *pb.SetBaitTierRequest) (*pb.SetBaitTierResponse, error) {
	return &pb.SetBaitTierResponse{}, nil
}
