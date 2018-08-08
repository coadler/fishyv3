package main

import (
	"fmt"
	"net"

	"github.com/coadler/fishyv3/internal/handlers"
	"github.com/coadler/fishyv3/pb"
	"github.com/grpc-ecosystem/go-grpc-middleware"
	"github.com/grpc-ecosystem/go-grpc-middleware/logging/zap"
	"github.com/grpc-ecosystem/go-grpc-middleware/recovery"
	"github.com/grpc-ecosystem/go-grpc-middleware/tags"
	"github.com/grpc-ecosystem/go-grpc-prometheus"
	"go.uber.org/zap"
	"google.golang.org/grpc"
)

func main() {
	logger, err := zap.NewDevelopment()
	if err != nil {
		must(err)
	}

	lis, err := net.Listen("tcp", ":8080")
	if err != nil {
		logger.Fatal("failed to listen", zap.Error(err))
	}

	srv := grpc.NewServer(
		grpc.UnaryInterceptor(
			grpc_middleware.ChainUnaryServer(
				grpc_ctxtags.UnaryServerInterceptor(),
				grpc_prometheus.UnaryServerInterceptor,
				grpc_zap.UnaryServerInterceptor(logger),
				grpc_recovery.UnaryServerInterceptor(),
			),
		),
	)
	pb.RegisterFishyServer(srv, fishyv3.NewFishyServer(logger))
	fmt.Println("Listening on port :8080")
	srv.Serve(lis)
}

func must(err error) {
	if err != nil {
		panic(err)
	}
}
