// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"database/sql/driver"
	"errors"
)

// Timeofday is the 'timeofday' enum type from schema 'public'.
type Timeofday uint16

const (
	// TimeofdayBoth is the 'both' Timeofday.
	TimeofdayBoth = Timeofday(1)

	// TimeofdayMorning is the 'morning' Timeofday.
	TimeofdayMorning = Timeofday(2)

	// TimeofdayNight is the 'night' Timeofday.
	TimeofdayNight = Timeofday(3)
)

// String returns the string value of the Timeofday.
func (t Timeofday) String() string {
	var enumVal string

	switch t {
	case TimeofdayBoth:
		enumVal = "both"

	case TimeofdayMorning:
		enumVal = "morning"

	case TimeofdayNight:
		enumVal = "night"
	}

	return enumVal
}

// MarshalText marshals Timeofday into text.
func (t Timeofday) MarshalText() ([]byte, error) {
	return []byte(t.String()), nil
}

// UnmarshalText unmarshals Timeofday from text.
func (t *Timeofday) UnmarshalText(text []byte) error {
	switch string(text) {
	case "both":
		*t = TimeofdayBoth

	case "morning":
		*t = TimeofdayMorning

	case "night":
		*t = TimeofdayNight

	default:
		return errors.New("invalid Timeofday")
	}

	return nil
}

// Value satisfies the sql/driver.Valuer interface for Timeofday.
func (t Timeofday) Value() (driver.Value, error) {
	return t.String(), nil
}

// Scan satisfies the database/sql.Scanner interface for Timeofday.
func (t *Timeofday) Scan(src interface{}) error {
	buf, ok := src.([]byte)
	if !ok {
		return errors.New("invalid Timeofday")
	}

	return t.UnmarshalText(buf)
}