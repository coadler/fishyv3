package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) StartGatherBait(ctx context.Context, req *pb.StartGatherBaitRequest) (*pb.StartGatherBaitResponse, error) {
	return &pb.StartGatherBaitResponse{}, nil
}

func (s *FishyServerImpl) CheckGatherBait(ctx context.Context, req *pb.CheckGatherBaitRequest) (*pb.CheckGatherBaitResponse, error) {
	return &pb.CheckGatherBaitResponse{
		Remaining: 9254,
	}, nil
}
