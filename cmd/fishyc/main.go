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

	_, err = c.Unblacklist(context.TODO(), &pb.UnblacklistRequest{User: "105484726235607040"})
	fmt.Println(err)
}
