package main

import (
	"context"
	"fmt"

	"github.com/coadler/fishyv3/pb"
	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("localhost:8080", grpc.WithInsecure())
	if err != nil {
		panic(err.Error())
	}
	c := pb.NewFishyClient(conn)

	res, err := c.GetBaitTier(context.TODO(), &pb.GetBaitTierRequest{User: "122221539377676289"})
	fmt.Println(err)
	fmt.Println(*res)
}
