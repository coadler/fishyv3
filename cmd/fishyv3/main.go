package main

import (
	"fmt"
	"log"
	"net"

	"github.com/ThyLeader/fishyv3"
	"github.com/ThyLeader/fishyv3/pb"
	"google.golang.org/grpc"
)

func main() {
	lis, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	srv := grpc.NewServer()
	pb.RegisterFishyServer(srv, &fishyv3.FishyServer{})
	fmt.Println("Listening on port :8080")
	srv.Serve(lis)
}
