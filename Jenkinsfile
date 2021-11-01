pipeline {
   agent any
    stages{
        stage("Checkout") {
            checkout scm
        }
        stage("terraform init") {
            steps{
                sh ('terraform init')
            }
        }
        stage("terraform plan"){
            steps{
                echo "Terraform plan start"
                sh ('terraform plan --auto-approve')
            }
        }
    }
}