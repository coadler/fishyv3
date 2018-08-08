package converter

import (
	"fmt"

	"github.com/coadler/fishyv3/pb"
)

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
