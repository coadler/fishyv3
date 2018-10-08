package fishyv3

import (
	"context"
	"database/sql"

	"go.uber.org/zap"
	// it wants me to put a comment here
	// i guess if im writing a comment i'll at least
	// put something useful
	// import postgres sql driver
	_ "github.com/lib/pq"
	"github.com/pkg/errors"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

// FishyServerImpl is an implementation of FishyServer.
type FishyServerImpl struct {
	log *zap.Logger

	db *sql.DB
}

var _ pb.FishyServer = &FishyServerImpl{}

// NewFishyServer returns an implementation of FishyServer.
func NewFishyServer(logger *zap.Logger, db *sql.DB) *FishyServerImpl {
	return &FishyServerImpl{
		logger,
		db,
	}
}

// Fishy handles the fishy protobuf route.
func (s *FishyServerImpl) Fishy(ctx context.Context, req *pb.FishRequest) (*pb.FishResponse, error) {
	err := inTxn(ctx, s.db, func(txn models.XODB) error {
		// this will error if the user is gathering bait
		_, err := getBaitInv(ctx, txn, req.User, true)
		if err != nil {
			return err
		}

		equipped, err := models.EquippedItemByUser(txn, req.User)
		if err != nil {
			return liftDB(err, "failed to get equipped items")
		}

		err = requireTier1Items(txn, equipped)
		if err != nil {
			return err
		}

		return nil
	})

	return &pb.FishResponse{}, err
}

func requireTier1Items(db models.XODB, equipped *models.EquippedItem) error {
	if equipped.Rod == 0 {
		ee, err := models.EasterEggByUserEasterEgg(db, equipped.User, models.EasterEggTypeNoRod)
		if err != nil {
			if errors.Cause(err) != sql.ErrNoRows {
				return liftDB(err, "failed to read easter err")
			}

			*ee = models.EasterEgg{
				User:      equipped.User,
				EasterEgg: models.EasterEggTypeNoRod,
				Amt:       0,
			}
		}

		ee.Amt++
		if err := ee.Save(db); err != nil {
			return liftDB(err, "failed to save easter egg")
		}
		return errors.New("")
	}

	return nil
}

func getEEResponse(ee *models.EasterEgg) (string, bool) {
	switch ee.EasterEgg {
	case models.EasterEggTypeNoRod:
		n := ee.Amt / 10
		return lmao[n], n >= len(lmao)-1
	default:
		return "", false
	}
}

var lmao = []string{
	"You pretend to fish with an imaginary fishing rod\nThe other fishermen look at you in disgust. (*maybe you should buy a fishing rod*)",
	"Your determination to catch a fish with your imaginary fishing rod starts to draw a crowd.\nWill you triumph?",
	"The crowd begins to disperse, but your determination is higher than ever.",
	"An old fisherman approaches you, and hands you a fishing rod and hook with great pity. *was this your plan all along?*\nYou gain a tier 1 rod and hook. Good job.",
}
