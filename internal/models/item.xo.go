// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"errors"
)

// Item represents a row from 'public.items'.
type Item struct {
	ID          int      `json:"id"`          // id
	Type        Itemtype `json:"type"`        // type
	Tier        int      `json:"tier"`        // tier
	Price       int      `json:"price"`       // price
	Effect      float64  `json:"effect"`      // effect
	Description string   `json:"description"` // description

	// xo fields
	_exists, _deleted bool
}

// Exists determines if the Item exists in the database.
func (i *Item) Exists() bool {
	return i._exists
}

// Deleted provides information if the Item has been deleted from the database.
func (i *Item) Deleted() bool {
	return i._deleted
}

// Insert inserts the Item to the database.
func (i *Item) Insert(db XODB) error {
	var err error

	// if already exist, bail
	if i._exists {
		return errors.New("insert failed: already exists")
	}

	// sql insert query, primary key provided by sequence
	const sqlstr = `INSERT INTO public.items (` +
		`"type", "tier", "price", "effect", "description"` +
		`) VALUES (` +
		`$1, $2, $3, $4, $5` +
		`) RETURNING "id"`

	// run query
	XOLog(sqlstr, i.Type, i.Tier, i.Price, i.Effect, i.Description)
	err = db.QueryRow(sqlstr, i.Type, i.Tier, i.Price, i.Effect, i.Description).Scan(&i.ID)
	if err != nil {
		return err
	}

	// set existence
	i._exists = true

	return nil
}

// Update updates the Item in the database.
func (i *Item) Update(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !i._exists {
		return errors.New("update failed: does not exist")
	}

	// if deleted, bail
	if i._deleted {
		return errors.New("update failed: marked for deletion")
	}

	// sql query
	const sqlstr = `UPDATE public.items SET (` +
		`"type", "tier", "price", "effect", "description"` +
		`) = ( ` +
		`$1, $2, $3, $4, $5` +
		`) WHERE "id" = $6`

	// run query
	XOLog(sqlstr, i.Type, i.Tier, i.Price, i.Effect, i.Description, i.ID)
	_, err = db.Exec(sqlstr, i.Type, i.Tier, i.Price, i.Effect, i.Description, i.ID)
	return err
}

// Save saves the Item to the database.
func (i *Item) Save(db XODB) error {
	if i.Exists() {
		return i.Update(db)
	}

	return i.Insert(db)
}

// Upsert performs an upsert for Item.
//
// NOTE: PostgreSQL 9.5+ only
func (i *Item) Upsert(db XODB) error {
	var err error

	// if already exist, bail
	if i._exists {
		return errors.New("insert failed: already exists")
	}

	// sql query
	const sqlstr = `INSERT INTO public.items (` +
		`"id", "type", "tier", "price", "effect", "description"` +
		`) VALUES (` +
		`$1, $2, $3, $4, $5, $6` +
		`) ON CONFLICT ("id") DO UPDATE SET (` +
		`"id", "type", "tier", "price", "effect", "description"` +
		`) = (` +
		`EXCLUDED."id", EXCLUDED."type", EXCLUDED."tier", EXCLUDED."price", EXCLUDED."effect", EXCLUDED."description"` +
		`)`

	// run query
	XOLog(sqlstr, i.ID, i.Type, i.Tier, i.Price, i.Effect, i.Description)
	_, err = db.Exec(sqlstr, i.ID, i.Type, i.Tier, i.Price, i.Effect, i.Description)
	if err != nil {
		return err
	}

	// set existence
	i._exists = true

	return nil
}

// Delete deletes the Item from the database.
func (i *Item) Delete(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !i._exists {
		return nil
	}

	// if deleted, bail
	if i._deleted {
		return nil
	}

	// sql query
	const sqlstr = `DELETE FROM public.items WHERE "id" = $1`

	// run query
	XOLog(sqlstr, i.ID)
	_, err = db.Exec(sqlstr, i.ID)
	if err != nil {
		return err
	}

	// set deleted
	i._deleted = true

	return nil
}

// ItemByID retrieves a row from 'public.items' as a Item.
//
// Generated from index 'items_pkey'.
func ItemByID(db XODB, id int) (*Item, error) {
	var err error

	// sql query
	const sqlstr = `SELECT ` +
		`"id", "type", "tier", "price", "effect", "description" ` +
		`FROM public.items ` +
		`WHERE "id" = $1`

	// run query
	XOLog(sqlstr, id)
	i := Item{}

	err = db.QueryRow(sqlstr, id).Scan(&i.ID, &i.Type, &i.Tier, &i.Price, &i.Effect, &i.Description)
	if err != nil {
		return &i, err
	}

	i._exists = true
	return &i, nil
}
