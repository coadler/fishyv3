// Package models contains the types for schema 'public'.
package models

// Code generated by xo. DO NOT EDIT.

// AllTiers represents a row from '[custom all_tiers]'.
type AllTiers struct {
	Tier     int // tier
	Required int // required
}

// GetAllTiers runs a custom query, returning results as AllTiers.
func GetAllTiers(db XODB) ([]*AllTiers, error) {
	var err error

	// sql query
	const sqlstr = `select * ` +
		`from tiers`

	// run query
	XOLog(sqlstr)
	q, err := db.Query(sqlstr)
	if err != nil {
		return nil, err
	}
	defer q.Close()

	// load results
	res := []*AllTiers{}
	for q.Next() {
		at := AllTiers{}

		// scan
		err = q.Scan(&at.Tier, &at.Required)
		if err != nil {
			return nil, err
		}

		res = append(res, &at)
	}

	return res, nil
}
