package main

import (
	"context"
	"fmt"
	"os"

	redisv1alpha1 "github.com/ucloud/redis-cluster-operator/pkg/apis/redis/v1alpha1"

	"k8s.io/apimachinery/pkg/types"
	"sigs.k8s.io/controller-runtime/pkg/client"
	"sigs.k8s.io/controller-runtime/pkg/client/config"
)

func main() {
	cfg, err := config.GetConfig()
	if err != nil {
		os.Exit(1)
	}

	c, err := client.New(cfg, client.Options{})
	if err != nil {
		os.Exit(1)
	}

	instance := &redisv1alpha1.DistributedRedisCluster{}
	err = c.Get(context.TODO(),
		types.NamespacedName{"default", "rbd-distributedrediscluster"}, instance)
	if err != nil {
		os.Exit(1)
	}

	instance.Spec.MasterSize = 5
	err = c.Update(context.TODO(), instance)
	fmt.Println(err)
}
