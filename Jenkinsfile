pipeline {
   agent any
    stages{
        stage("Checkout") {
            steps{
                checkout scm
            }
        }
        stage("Test") {
            steps{
                dir('src'){
                    sh ('/usr/bin/go test ./... -cover')
                }
            }
        }
        stage("Build"){
            steps{
                dir('src'){
                    sh ('GOOS=linux GOARCH=amd64 CGO_ENABLED=0 /usr/bin/go build -o bin/main main.go')
                }
            }
        }
        stage("terraform init") {
            steps{
                dir('terraform'){
                    sh ('/usr/local/bin/terraform init')
                }
            }
        }
        stage("terraform plan"){
            steps{
                dir('terraform'){
                    echo "terraform plan start"
                    sh ('/usr/local/bin/terraform plan')
                }
            }
        }
    }
}