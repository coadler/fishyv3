package converter

import (
	"github.com/coadler/fishyv3/internal/models"
	"github.com/coadler/fishyv3/pb"
)

func FromPBLocation(loc pb.Location) models.Location {
	switch loc {
	case pb.Location_LAKE:
		return models.LocationLake
	case pb.Location_OCEAN:
		return models.LocationOcean
	case pb.Location_RIVER:
		return models.LocationRiver
	default:
		panic("invalid enum " + loc.String())
	}
}

func FromDBLocation(loc models.Location) pb.Location {
	switch loc {
	case models.LocationLake:
		return pb.Location_LAKE
	case models.LocationOcean:
		return pb.Location_OCEAN
	case models.LocationRiver:
		return pb.Location_RIVER
	default:
		panic("invalid enum " + loc.String())
	}
}
