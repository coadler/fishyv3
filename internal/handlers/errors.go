package fishyv3

import (
	"database/sql"
	"strings"

	"github.com/pkg/errors"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func liftDB(err error, msg string) error {
	if err == nil {
		return nil
	}

	if errors.Cause(err) == sql.ErrNoRows {
		return status.Error(codes.NotFound, errors.Wrap(err, msg).Error())
	}
	if strings.Contains(errors.Cause(err).Error(), "duplicate key value") {
		return status.Error(codes.AlreadyExists, errors.Wrap(err, msg).Error())
	}

	return status.Error(codes.Internal, errors.Wrap(err, msg).Error())
}
