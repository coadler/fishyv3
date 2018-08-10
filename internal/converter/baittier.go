package converter

import (
	"fmt"

	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func FromDBBaitInventory(inv *models.BaitInventory) *pb.BaitInventory {
	return &pb.BaitInventory{
		T1: int32(inv.Tier1),
		T2: int32(inv.Tier2),
		T3: int32(inv.Tier3),
		T4: int32(inv.Tier4),
		T5: int32(inv.Tier5),
	}
}

func FromDBBaitTier(tier int) pb.BaitTier {
	switch tier {
	case 1:
		return pb.BaitTier_T1
	case 2:
		return pb.BaitTier_T2
	case 3:
		return pb.BaitTier_T3
	case 4:
		return pb.BaitTier_T4
	case 5:
		return pb.BaitTier_T5
	default:
		panic(fmt.Sprintf("invalid bait tier %d", tier))
	}
}

func FromPBBaitTier(tier pb.BaitTier) int {
	return int(tier)
}
