pipeline {
   agent any
    stages{
        stage("Checkout") {
            steps{
                checkout scm
            }
        }
        stage("terraform init") {
            steps{
                dir('terraform'){
                    sh ('terraform init')
                }
            }
        }
        stage("terraform plan"){
            steps{
                dir('terraform'){
                    echo "terraform plan start"
                    sh ('terraform plan')
                }
            }
        }
    }
}