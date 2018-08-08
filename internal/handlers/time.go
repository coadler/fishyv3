package fishyv3

import (
	"context"
	"time"

	"github.com/coadler/fishyv3/pb"
)

var (
	morning1 = time.Date(0, 0, 0, 9, 0, 0, 0, time.UTC)
	morning2 = time.Date(0, 0, 0, 15, 59, 59, 999, time.UTC)
	night1   = time.Date(0, 0, 0, 16, 0, 0, 0, time.UTC)
	night2   = time.Date(0, 0, 0, 8, 59, 59, 999, time.UTC)
)

func (s *FishyServerImpl) CheckTime(ctx context.Context, req *pb.CheckTimeRequest) (*pb.CheckTimeResponse, error) {
	var (
		now     = time.Now().UTC()
		morning = now.After(morning1) && now.Before(morning2)
		night   = now.After(night1) || now.Before(night2)
	)

	return &pb.CheckTimeResponse{
		Time:    now.Format(time.Kitchen),
		Night:   night,
		Morning: morning,
	}, nil
}
