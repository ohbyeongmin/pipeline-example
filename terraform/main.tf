terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = "ap-northeast-2"
}

data "archive_file" "add_function" {
    type = "zip"

    source_dir = "${path.module}/../src/bin"
    output_path = "${path.module}/lambda/add.zip"
}

resource "aws_s3_bucket_object" "add_function" {
  bucket = "crawling-test-obm"

  key = "add_function/add.zip"
  source = data.archive_file.add_function.output_path

  etag = filemd5(data.archive_file.add_function.output_path)
}

resource "aws_lambda_function" "add_lambda" {
  function_name = "add"

  s3_bucket = "crawling-test-obm"
  s3_key = aws_s3_bucket_object.add_function.key

  runtime = "go1.x"
  handler = "main"

  source_code_hash = data.archive_file.add_function.output_base64sha256

  role = aws_iam_role.add_lambda_role.arn
}

resource "aws_iam_role" "add_lambda_role" {
  name = "add_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_policy" "policy" {
  name        = "add-policy"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction",
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
  })
}

resource "aws_iam_role_policy_attachment" "add_lambda_policy" {
  role       = aws_iam_role.add_lambda_role.name
  policy_arn = aws_iam_policy.policy.arn
}