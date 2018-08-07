package fishyv3

import "time"

var (
	Morning1 = time.Date(0, 0, 0, 9, 0, 0, 0, time.UTC)
	Morning2 = time.Date(0, 0, 0, 15, 59, 59, 999, time.UTC)
	Night1   = time.Date(0, 0, 0, 16, 0, 0, 0, time.UTC)
	Night2   = time.Date(0, 0, 0, 8, 59, 59, 999, time.UTC)
)
