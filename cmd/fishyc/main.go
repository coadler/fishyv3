package main

import (
	"context"
	"fmt"

	"github.com/coadler/fishyv3/pb"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("localhost:8080", grpc.WithInsecure())
	if err != nil {
		panic(err.Error())
	}
	c := pb.NewFishyClient(conn)

	res, err := c.GuildLeaderboard(context.TODO(), &pb.GuildLeaderboardRequest{Guild: "320896491596283906", Page: 1})
	if err != nil {
		fmt.Println(err)
		return
	}
	for _, e := range res.Users {
		fmt.Println(e.User, e.Score)
	}
}

// func main() {
// 	db, err := sql.Open("postgres", "host=localhost user=colinadler dbname=fishyv3 sslmode=disable")
// 	if err != nil {
// 		log.Fatal("failed to connect to postgres", zap.Error(err))
// 	}

// 	for i := 0; i < 20; i++ {
// 		rand.Seed(time.Now().UnixNano())

// 		err := (&models.GuildRanking{
// 			User:    lul(),
// 			Guild:   "320896491596283906",
// 			Score:   rand.Intn(500),
// 			Garbage: rand.Intn(500),
// 			Fish:    rand.Intn(500),
// 			Casts:   rand.Intn(500),
// 		}).Save(db)
// 		if err != nil {
// 			panic(err)
// 		}
// 	}
// }

// func lul() string {
// 	return fmt.Sprintf("%d", shortid.New())
// }
