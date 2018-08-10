package fishyv3

import (
	"context"
	"database/sql"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
	"github.com/pkg/errors"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

var (
	ErrBlacklisted = status.Error(codes.PermissionDenied, "user is blacklisted")
)

// Blacklist is the GRPC route for blacklisting a user from fishy.
func (s *FishyServerImpl) Blacklist(ctx context.Context, req *pb.BlacklistRequest) (*pb.BlacklistResponse, error) {
	return &pb.BlacklistResponse{}, inTxn(ctx, s.db, func(txn models.XODB) error {
		return liftDB(
			(&models.Blacklist{
				User: req.User,
			}).Insert(txn),
			"failed to insert blacklist",
		)
	})
}

// Unblacklist is the GRPC route for unblacklisting a user from fishy.
func (s *FishyServerImpl) Unblacklist(ctx context.Context, req *pb.UnblacklistRequest) (res *pb.UnblacklistResponse, err error) {
	return res, inTxn(ctx, s.db, func(txn models.XODB) error {
		return liftDB(
			(&models.Blacklist{
				User: req.User,
			}).Delete(txn),
			"failed to delete blacklist",
		)
	})
}

func BlacklistInterceptor(db *sql.DB) grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {
		var user string
		switch r := req.(type) {
		case *pb.InventoryRequest:
			user = r.User
		case *pb.GetLocationRequest:
			user = r.User
		case *pb.SetLocationRequest:
			user = r.User
		case *pb.BuyItemRequest:
			user = r.User
		case *pb.StartGatherBaitRequest:
			user = r.User
		case *pb.CheckGatherBaitRequest:
			user = r.User
		case *pb.GetBaitInventoryRequest:
			user = r.User
		case *pb.BuyBaitRequest:
			user = r.User
		case *pb.GetBaitTierRequest:
			user = r.User
		case *pb.SetBaitTierRequest:
			user = r.User
		case *pb.SellFishRequest:
			user = r.User
		default:
			return handler(ctx, req)
		}

		_, err := models.BlacklistByUser(db, user)
		if err != nil {
			if errors.Cause(err) != sql.ErrNoRows {
				return nil, liftDB(err, "failed to read blacklist")
			}

			// continue, blacklist doesn't exist
			return handler(ctx, req)
		}

		return nil, ErrBlacklisted
	}
}
