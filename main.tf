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
  name = "${var.aws_iam_role1}"
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
    policy_arn = "arn:aws:iam::aws:policy/service-role/DynamoDBWriteAccess"
}
