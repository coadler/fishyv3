package fishyv3

import (
	"context"

	"github.com/coadler/fishyv3/pb"
)

func (s *FishyServerImpl) Leaderboard(ctx context.Context, req *pb.LeaderboardRequest) (*pb.LeaderboardResponse, error) {
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
