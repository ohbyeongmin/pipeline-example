pipeline {
   stage('Clone') {
       checkout scm
   }
   stage("terraform init") {
       steps{
           sh ('terraform init')
       }
   }
   stage("terraform plan"){
       echo "Terraform plan start"
       sh ('terraform plan --auto-approve')
   }
}