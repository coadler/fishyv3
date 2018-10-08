// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"database/sql/driver"
	"errors"
)

// EasterEggType is the 'easter_egg_type' enum type from schema 'public'.
type EasterEggType uint16

const (
	// EasterEggTypeNoRod is the 'no_rod' EasterEggType.
	EasterEggTypeNoRod = EasterEggType(1)

	// EasterEggTypeNoHook is the 'no_hook' EasterEggType.
	EasterEggTypeNoHook = EasterEggType(2)
)

// String returns the string value of the EasterEggType.
func (eet EasterEggType) String() string {
	var enumVal string

	switch eet {
	case EasterEggTypeNoRod:
		enumVal = "no_rod"

	case EasterEggTypeNoHook:
		enumVal = "no_hook"
	}

	return enumVal
}

// MarshalText marshals EasterEggType into text.
func (eet EasterEggType) MarshalText() ([]byte, error) {
	return []byte(eet.String()), nil
}

// UnmarshalText unmarshals EasterEggType from text.
func (eet *EasterEggType) UnmarshalText(text []byte) error {
	switch string(text) {
	case "no_rod":
		*eet = EasterEggTypeNoRod

	case "no_hook":
		*eet = EasterEggTypeNoHook

	default:
		return errors.New("invalid EasterEggType")
	}

	return nil
}

// Value satisfies the sql/driver.Valuer interface for EasterEggType.
func (eet EasterEggType) Value() (driver.Value, error) {
	return eet.String(), nil
}

// Scan satisfies the database/sql.Scanner interface for EasterEggType.
func (eet *EasterEggType) Scan(src interface{}) error {
	buf, ok := src.([]byte)
	if !ok {
		return errors.New("invalid EasterEggType")
	}

	return eet.UnmarshalText(buf)
}
