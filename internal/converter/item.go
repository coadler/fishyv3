package converter

import (
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func FromPBItem(item pb.Item) models.Item {
	switch item {
	case pb.Item_BAIT:
		return models.ItemBait
	case pb.Item_BAITBOX:
		return models.ItemBaitBox
	case pb.Item_HOOK:
		return models.ItemHook
	case pb.Item_ROD:
		return models.ItemRod
	case pb.Item_VEHICLE:
		return models.ItemVehicle
	default:
		panic("invalid item " + item.String())
	}
}

func FromDBItem(item models.Item) pb.Item {
	switch item {
	case models.ItemBait:
		return pb.Item_BAIT
	case models.ItemBaitBox:
		return pb.Item_BAITBOX
	case models.ItemHook:
		return pb.Item_HOOK
	case models.ItemRod:
		return pb.Item_ROD
	case models.ItemVehicle:
		return pb.Item_VEHICLE
	default:
		panic("invalid item " + item.String())
	}
}
