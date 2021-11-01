package main

import (
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

func AddNum(a, b int) int {
	return a + b
}

func LambdaHandler() error {
	a, b := 1, 2
	log.Printf("%d + %d = %d\n", a, b, AddNum(a, b))
	return nil
}

func main() {
	lambda.Start(LambdaHandler())
}
