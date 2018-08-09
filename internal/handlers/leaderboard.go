package fishyv3

import (
	"context"

	"google.golang.org/grpc/codes"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"google.golang.org/grpc/status"
)

func (s *FishyServerImpl) GlobalLeaderboard(ctx context.Context, req *pb.GlobalLeaderboardRequest) (res *pb.LeaderboardResponse, _ error) {
	if req.Page < 1 {
		return res, status.Error(codes.InvalidArgument, "page must be >0")
	}

	lb, err := models.GlobalLeaderboardDescsByOffset(s.db, int(req.Page-1)*10)
	if err != nil {
		return res, liftDB(err, "failed to get global leaderboard users")
	}

	res = &pb.LeaderboardResponse{
		Users: []*pb.LeaderboardUser{},
	}
	for _, e := range lb {
		res.Users = append(res.Users, &pb.LeaderboardUser{User: e.User, Score: int32(e.Score)})
	}

	return
}

func (s *FishyServerImpl) GuildLeaderboard(ctx context.Context, req *pb.GuildLeaderboardRequest) (res *pb.LeaderboardResponse, _ error) {
	if req.Page < 1 {
		return res, status.Error(codes.InvalidArgument, "page must be >0")
	}

	lb, err := models.GuildLeaderboardDescsByGuildOffest(s.db, req.Guild, int(req.Page-1)*10)
	if err != nil {
		return res, liftDB(err, "failed to get guild leaderboard users")
	}

	res = &pb.LeaderboardResponse{
		Users: []*pb.LeaderboardUser{},
	}
	for _, e := range lb {
		res.Users = append(res.Users, &pb.LeaderboardUser{User: e.User, Score: int32(e.Score)})
	}

	return
}
