// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"database/sql/driver"
	"errors"
)

// Item is the 'item' enum type from schema 'public'.
type Item uint16

const (
	// ItemBait is the 'bait' Item.
	ItemBait = Item(1)

	// ItemRod is the 'rod' Item.
	ItemRod = Item(2)

	// ItemHook is the 'hook' Item.
	ItemHook = Item(3)

	// ItemVehicle is the 'vehicle' Item.
	ItemVehicle = Item(4)

	// ItemBaitBox is the 'bait_box' Item.
	ItemBaitBox = Item(5)
)

// String returns the string value of the Item.
func (i Item) String() string {
	var enumVal string

	switch i {
	case ItemBait:
		enumVal = "bait"

	case ItemRod:
		enumVal = "rod"

	case ItemHook:
		enumVal = "hook"

	case ItemVehicle:
		enumVal = "vehicle"

	case ItemBaitBox:
		enumVal = "bait_box"
	}

	return enumVal
}

// MarshalText marshals Item into text.
func (i Item) MarshalText() ([]byte, error) {
	return []byte(i.String()), nil
}

// UnmarshalText unmarshals Item from text.
func (i *Item) UnmarshalText(text []byte) error {
	switch string(text) {
	case "bait":
		*i = ItemBait

	case "rod":
		*i = ItemRod

	case "hook":
		*i = ItemHook

	case "vehicle":
		*i = ItemVehicle

	case "bait_box":
		*i = ItemBaitBox

	default:
		return errors.New("invalid Item")
	}

	return nil
}

// Value satisfies the sql/driver.Valuer interface for Item.
func (i Item) Value() (driver.Value, error) {
	return i.String(), nil
}

// Scan satisfies the database/sql.Scanner interface for Item.
func (i *Item) Scan(src interface{}) error {
	buf, ok := src.([]byte)
	if !ok {
		return errors.New("invalid Item")
	}

	return i.UnmarshalText(buf)
}