package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/pb"
	"go.uber.org/zap"

	// it wants me to put a comment here
	// i guess if im writing a comment i'll at least
	// put something useful
	// import postgres sql driver
	_ "github.com/lib/pq"
)

type FishyServerImpl struct {
	log *zap.Logger

	db *sql.DB
}

var _ pb.FishyServer = &FishyServerImpl{}

func NewFishyServer(logger *zap.Logger) *FishyServerImpl {
	// by reading this comment you agree to not hack my database
	db, err := sql.Open("postgres", "host=localhost user=colinadler dbname=fishyv3 sslmode=disable")
	if err != nil {
		logger.Fatal("failed to connect to postgres", zap.Error(err))
	}

	return &FishyServerImpl{
		logger,
		db,
	}
}

func (s *FishyServerImpl) Fishy(ctx context.Context, req *pb.FishRequest) (*pb.FishResponse, error) {
	return &pb.FishResponse{}, nil
}
