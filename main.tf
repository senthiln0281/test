provider "aws"{
  region = "${var.region}"
}
resource "aws_s3_bucket" "497704" {
  bucket = "${var.bucket}"
  acl = "${var.acl}"
  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket}/*",
      "Principal": "*"
    }
  ]
}
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
resource "aws_cognito_user_pool" "pool" {
  name = "WildRydes"
}
resource "aws_cognito_user_pool_client" "client" {
  name = "WildRydesWebApp"

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
  generate_secret = false
  
}
resource "aws_dynamodb_table" "dynamodb-table" {

  name           = "${var.aws_dynamodb_table}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"
  write_capacity     = 10
  read_capacity      = 10

  attribute {
    name = "RideId"
    type = "S"
  }
  attribute {
    name = "RideTitle"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled = false
  }


}
resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.aws_iam_role}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "exec-role" {
    role      = "${aws_iam_role.iam_for_lambda.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}
resource "aws_iam_role_policy_attachment" "exec-role1" {
    role      = "${var.aws_iam_role}"
    policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_lambda_function" "RequestUnicorn" {
#  filename         = "requestunicorn.zip"
  function_name    = "${var.function_name}"
  role             = "arn:aws:iam::033219852540:role/WildRydesLambda"
  handler          = "requestunicorn.handler"
  runtime          = "nodejs6.10"
  s3_bucket = "${var.bucket}"
  s3_key = "requestunicorn.zip"
}
resource "aws_s3_bucket_object" "object" {
  bucket = "${var.bucket}"
  key    = "test.html"
  source = "/usr/bin/test.html"
  content_type = "text/html"
}
resource "aws_s3_bucket_object" "object1" {
  bucket = "${var.bucket}"
  key    = "requestunicorn.zip"
  source = "/usr/bin/requestunicorn.zip"
}

resource "aws_iam_policy" "policy" {
  name        = "${var.aws_iam_policy}"
  description = "Provide write access to Lambda for DynamoDB"

  policy = <<EOF
{
   "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:PutItem"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


data "terraform_remote_state" "foo" {
  backend = "local"

  config {
    path = "/usr/bin/terraform.tfstate"
  }
}
resource "aws_api_gateway_authorizer" "WildRydes" {
  name          = "WildRydes"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = "${aws_api_gateway_rest_api.WildRydes.id}"
  provider_arns = ["${aws_cognito_user_pool.pool.arn}"]
}
  

resource "aws_api_gateway_rest_api" "WildRydes" {
  name        = "${var.api}"

  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_resource" "ride" {
  rest_api_id = "${aws_api_gateway_rest_api.WildRydes.id}"
  parent_id   = "${aws_api_gateway_rest_api.WildRydes.root_resource_id}"
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "POST" {
  rest_api_id   = "${aws_api_gateway_rest_api.WildRydes.id}"
  resource_id   = "${aws_api_gateway_resource.ride.id}"
  http_method   = "POST"
  authorization = "NONE"
}
