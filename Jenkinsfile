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
                sh ('terraform/terraform init')
            }
        }
        stage("terraform plan"){
            steps{
                echo "Terraform plan start"
                sh ('terraform/terraform plan --auto-approve')
            }
        }
    }
}