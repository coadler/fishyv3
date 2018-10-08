// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"errors"
)

// EasterEggString represents a row from 'public.easter_egg_strings'.
type EasterEggString struct {
	ID    int           `json:"id"`    // id
	Data  string        `json:"data"`  // data
	Order int           `json:"order"` // order
	Type  EasterEggType `json:"type"`  // type

	// xo fields
	_exists, _deleted bool
}

// Exists determines if the EasterEggString exists in the database.
func (ees *EasterEggString) Exists() bool {
	return ees._exists
}

// Deleted provides information if the EasterEggString has been deleted from the database.
func (ees *EasterEggString) Deleted() bool {
	return ees._deleted
}

// Insert inserts the EasterEggString to the database.
func (ees *EasterEggString) Insert(db XODB) error {
	var err error

	// if already exist, bail
	if ees._exists {
		return errors.New("insert failed: already exists")
	}

	// sql insert query, primary key provided by sequence
	const sqlstr = `INSERT INTO public.easter_egg_strings (` +
		`"data", "order", "type"` +
		`) VALUES (` +
		`$1, $2, $3` +
		`) RETURNING "id"`

	// run query
	XOLog(sqlstr, ees.Data, ees.Order, ees.Type)
	err = db.QueryRow(sqlstr, ees.Data, ees.Order, ees.Type).Scan(&ees.ID)
	if err != nil {
		return err
	}

	// set existence
	ees._exists = true

	return nil
}

// Update updates the EasterEggString in the database.
func (ees *EasterEggString) Update(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !ees._exists {
		return errors.New("update failed: does not exist")
	}

	// if deleted, bail
	if ees._deleted {
		return errors.New("update failed: marked for deletion")
	}

	// sql query
	const sqlstr = `UPDATE public.easter_egg_strings SET (` +
		`"data", "order", "type"` +
		`) = ( ` +
		`$1, $2, $3` +
		`) WHERE "id" = $4`

	// run query
	XOLog(sqlstr, ees.Data, ees.Order, ees.Type, ees.ID)
	_, err = db.Exec(sqlstr, ees.Data, ees.Order, ees.Type, ees.ID)
	return err
}

// Save saves the EasterEggString to the database.
func (ees *EasterEggString) Save(db XODB) error {
	if ees.Exists() {
		return ees.Update(db)
	}

	return ees.Insert(db)
}

// Upsert performs an upsert for EasterEggString.
//
// NOTE: PostgreSQL 9.5+ only
func (ees *EasterEggString) Upsert(db XODB) error {
	var err error

	// if already exist, bail
	if ees._exists {
		return errors.New("insert failed: already exists")
	}

	// sql query
	const sqlstr = `INSERT INTO public.easter_egg_strings (` +
		`"id", "data", "order", "type"` +
		`) VALUES (` +
		`$1, $2, $3, $4` +
		`) ON CONFLICT ("id") DO UPDATE SET (` +
		`"id", "data", "order", "type"` +
		`) = (` +
		`EXCLUDED."id", EXCLUDED."data", EXCLUDED."order", EXCLUDED."type"` +
		`)`

	// run query
	XOLog(sqlstr, ees.ID, ees.Data, ees.Order, ees.Type)
	_, err = db.Exec(sqlstr, ees.ID, ees.Data, ees.Order, ees.Type)
	if err != nil {
		return err
	}

	// set existence
	ees._exists = true

	return nil
}

// Delete deletes the EasterEggString from the database.
func (ees *EasterEggString) Delete(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !ees._exists {
		return nil
	}

	// if deleted, bail
	if ees._deleted {
		return nil
	}

	// sql query
	const sqlstr = `DELETE FROM public.easter_egg_strings WHERE "id" = $1`

	// run query
	XOLog(sqlstr, ees.ID)
	_, err = db.Exec(sqlstr, ees.ID)
	if err != nil {
		return err
	}

	// set deleted
	ees._deleted = true

	return nil
}

// EasterEggStringByID retrieves a row from 'public.easter_egg_strings' as a EasterEggString.
//
// Generated from index 'easter_egg_strings_pkey'.
func EasterEggStringByID(db XODB, id int) (*EasterEggString, error) {
	var err error

	// sql query
	const sqlstr = `SELECT ` +
		`"id", "data", "order", "type" ` +
		`FROM public.easter_egg_strings ` +
		`WHERE "id" = $1`

	// run query
	XOLog(sqlstr, id)
	ees := EasterEggString{}

	err = db.QueryRow(sqlstr, id).Scan(&ees.ID, &ees.Data, &ees.Order, &ees.Type)
	if err != nil {
		return &ees, err
	}

	ees._exists = true
	return &ees, nil
}
