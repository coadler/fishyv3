// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

import (
	"errors"
)

// GuildRanking represents a row from 'public.guild_rankings'.
type GuildRanking struct {
	ID        int     `json:"id"`         // id
	User      string  `json:"user"`       // user
	Guild     string  `json:"guild"`      // guild
	Score     int     `json:"score"`      // score
	Garbage   int     `json:"garbage"`    // garbage
	Fish      int     `json:"fish"`       // fish
	Casts     int     `json:"casts"`      // casts
	AvgLength float64 `json:"avg_length"` // avg_length

	// xo fields
	_exists, _deleted bool
}

// Exists determines if the GuildRanking exists in the database.
func (gr *GuildRanking) Exists() bool {
	return gr._exists
}

// Deleted provides information if the GuildRanking has been deleted from the database.
func (gr *GuildRanking) Deleted() bool {
	return gr._deleted
}

// Insert inserts the GuildRanking to the database.
func (gr *GuildRanking) Insert(db XODB) error {
	var err error

	// if already exist, bail
	if gr._exists {
		return errors.New("insert failed: already exists")
	}

	// sql insert query, primary key provided by sequence
	const sqlstr = `INSERT INTO public.guild_rankings (` +
		`"user", "guild", "score", "garbage", "fish", "casts", "avg_length"` +
		`) VALUES (` +
		`$1, $2, $3, $4, $5, $6, $7` +
		`) RETURNING "id"`

	// run query
	XOLog(sqlstr, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength)
	err = db.QueryRow(sqlstr, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength).Scan(&gr.ID)
	if err != nil {
		return err
	}

	// set existence
	gr._exists = true

	return nil
}

// Update updates the GuildRanking in the database.
func (gr *GuildRanking) Update(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !gr._exists {
		return errors.New("update failed: does not exist")
	}

	// if deleted, bail
	if gr._deleted {
		return errors.New("update failed: marked for deletion")
	}

	// sql query
	const sqlstr = `UPDATE public.guild_rankings SET (` +
		`"user", "guild", "score", "garbage", "fish", "casts", "avg_length"` +
		`) = ( ` +
		`$1, $2, $3, $4, $5, $6, $7` +
		`) WHERE "id" = $8`

	// run query
	XOLog(sqlstr, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength, gr.ID)
	_, err = db.Exec(sqlstr, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength, gr.ID)
	return err
}

// Save saves the GuildRanking to the database.
func (gr *GuildRanking) Save(db XODB) error {
	if gr.Exists() {
		return gr.Update(db)
	}

	return gr.Insert(db)
}

// Upsert performs an upsert for GuildRanking.
//
// NOTE: PostgreSQL 9.5+ only
func (gr *GuildRanking) Upsert(db XODB) error {
	var err error

	// if already exist, bail
	if gr._exists {
		return errors.New("insert failed: already exists")
	}

	// sql query
	const sqlstr = `INSERT INTO public.guild_rankings (` +
		`"id", "user", "guild", "score", "garbage", "fish", "casts", "avg_length"` +
		`) VALUES (` +
		`$1, $2, $3, $4, $5, $6, $7, $8` +
		`) ON CONFLICT ("id") DO UPDATE SET (` +
		`"id", "user", "guild", "score", "garbage", "fish", "casts", "avg_length"` +
		`) = (` +
		`EXCLUDED."id", EXCLUDED."user", EXCLUDED."guild", EXCLUDED."score", EXCLUDED."garbage", EXCLUDED."fish", EXCLUDED."casts", EXCLUDED."avg_length"` +
		`)`

	// run query
	XOLog(sqlstr, gr.ID, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength)
	_, err = db.Exec(sqlstr, gr.ID, gr.User, gr.Guild, gr.Score, gr.Garbage, gr.Fish, gr.Casts, gr.AvgLength)
	if err != nil {
		return err
	}

	// set existence
	gr._exists = true

	return nil
}

// Delete deletes the GuildRanking from the database.
func (gr *GuildRanking) Delete(db XODB) error {
	var err error

	// if doesn't exist, bail
	if !gr._exists {
		return nil
	}

	// if deleted, bail
	if gr._deleted {
		return nil
	}

	// sql query
	const sqlstr = `DELETE FROM public.guild_rankings WHERE "id" = $1`

	// run query
	XOLog(sqlstr, gr.ID)
	_, err = db.Exec(sqlstr, gr.ID)
	if err != nil {
		return err
	}

	// set deleted
	gr._deleted = true

	return nil
}

// GuildRankingByID retrieves a row from 'public.guild_rankings' as a GuildRanking.
//
// Generated from index 'guild_rankings_pkey'.
func GuildRankingByID(db XODB, id int) (*GuildRanking, error) {
	var err error

	// sql query
	const sqlstr = `SELECT ` +
		`"id", "user", "guild", "score", "garbage", "fish", "casts", "avg_length" ` +
		`FROM public.guild_rankings ` +
		`WHERE "id" = $1`

	// run query
	XOLog(sqlstr, id)
	gr := GuildRanking{}

	err = db.QueryRow(sqlstr, id).Scan(&gr.ID, &gr.User, &gr.Guild, &gr.Score, &gr.Garbage, &gr.Fish, &gr.Casts, &gr.AvgLength)
	if err != nil {
		return &gr, err
	}

	gr._exists = true
	return &gr, nil
}

// GuildRankingByUserGuild retrieves a row from 'public.guild_rankings' as a GuildRanking.
//
// Generated from index 'user_guild'.
func GuildRankingByUserGuild(db XODB, user string, guild string) (*GuildRanking, error) {
	var err error

	// sql query
	const sqlstr = `SELECT ` +
		`"id", "user", "guild", "score", "garbage", "fish", "casts", "avg_length" ` +
		`FROM public.guild_rankings ` +
		`WHERE "user" = $1 AND "guild" = $2`

	// run query
	XOLog(sqlstr, user, guild)
	gr := GuildRanking{}

	err = db.QueryRow(sqlstr, user, guild).Scan(&gr.ID, &gr.User, &gr.Guild, &gr.Score, &gr.Garbage, &gr.Fish, &gr.Casts, &gr.AvgLength)
	if err != nil {
		return &gr, err
	}

	gr._exists = true
	return &gr, nil
}

// GuildRankingsByUserGuildScore retrieves a row from 'public.guild_rankings' as a GuildRanking.
//
// Generated from index 'user_guild_score'.
func GuildRankingsByUserGuildScore(db XODB, user string, guild string, score int) ([]*GuildRanking, error) {
	var err error

	// sql query
	const sqlstr = `SELECT ` +
		`"id", "user", "guild", "score", "garbage", "fish", "casts", "avg_length" ` +
		`FROM public.guild_rankings ` +
		`WHERE "user" = $1 AND "guild" = $2 AND "score" = $3`

	// run query
	XOLog(sqlstr, user, guild, score)
	q, err := db.Query(sqlstr, user, guild, score)
	if err != nil {
		return nil, err
	}
	defer q.Close()

	// load results
	res := []*GuildRanking{}
	for q.Next() {
		gr := GuildRanking{
			_exists: true,
		}

		// scan
		err = q.Scan(&gr.ID, &gr.User, &gr.Guild, &gr.Score, &gr.Garbage, &gr.Fish, &gr.Casts, &gr.AvgLength)
		if err != nil {
			return nil, err
		}

		res = append(res, &gr)
	}

	return res, nil
}
