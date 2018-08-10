package main

import (
	"context"
	"fmt"

	"github.com/coadler/fishyv3/pb"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
)

func main() {
	// conn, err := grpc.Dial("fishyv3.gcp.tatsu.cloud:80", grpc.WithInsecure())
	conn, err := grpc.Dial("localhost:8080", grpc.WithInsecure())
	if err != nil {
		panic(err.Error())
	}
	c := pb.NewFishyClient(conn)

	// _, err = c.StartGatherBait(context.TODO(), &pb.StartGatherBaitRequest{User: "320896491596283906"})
	// if err != nil {
	// 	fmt.Println(err)
	// 	return
	// }

	res, err := c.CheckGatherBait(context.TODO(), &pb.CheckGatherBaitRequest{User: "320896491596283906"})
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(res.Remaining)
}

// func main() {
// db, err := sql.Open("postgres", "host=localhost user=colinadler dbname=fishyv3 sslmode=disable")
// if err != nil {
// 	log.Fatal("failed to connect to postgres", zap.Error(err))
// }

// id := fmt.Sprintf("%d", shortid.New())
// err = (&models.BaitInventory{
// 	User: id,
// 	// Current: 1,
// }).Save(db)
// if err != nil {
// 	fmt.Println(err)
// 	return
// }

// inv, err := models.BaitInventoryByUser(db, id)
// if err != nil {
// 	fmt.Println(err)
// 	return
// }
// fmt.Println(inv.Gathering.IsZero())

// fut := time.Now().Add(6 * time.Hour)

// fmt.Println(fut.Sub(time.Now()))

// for i := 0; i < 20; i++ {
// 	rand.Seed(time.Now().UnixNano())

// 	err := (&models.GuildRanking{
// 		User:    lul(),
// 		Guild:   "320896491596283906",
// 		Score:   rand.Intn(500),
// 		Garbage: rand.Intn(500),
// 		Fish:    rand.Intn(500),
// 		Casts:   rand.Intn(500),
// 	}).Save(db)
// 	if err != nil {
// 		panic(err)
// 	}
// }
// }

// func lul() string {
// 	return fmt.Sprintf("%d", shortid.New())
// }
