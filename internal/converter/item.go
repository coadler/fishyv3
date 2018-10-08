package converter

import (
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func FromPBItem(item pb.Item) models.Itemtype {
	switch item {
	case pb.Item_BAIT:
		return models.ItemtypeBait
	case pb.Item_BAITBOX:
		return models.ItemtypeBaitBox
	case pb.Item_HOOK:
		return models.ItemtypeHook
	case pb.Item_ROD:
		return models.ItemtypeRod
	case pb.Item_VEHICLE:
		return models.ItemtypeVehicle
	default:
		panic("invalid item " + item.String())
	}
}

func FromDBItem(item models.Itemtype) pb.Item {
	switch item {
	case models.ItemtypeBait:
		return pb.Item_BAIT
	case models.ItemtypeBaitBox:
		return pb.Item_BAITBOX
	case models.ItemtypeHook:
		return pb.Item_HOOK
	case models.ItemtypeRod:
		return pb.Item_ROD
	case models.ItemtypeVehicle:
		return pb.Item_VEHICLE
	default:
		panic("invalid item " + item.String())
	}
}
