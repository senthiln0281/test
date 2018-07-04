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
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.aws_dynamodb_table}"
{

global_secondary_index {

  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"
  write_capacity     = 10
  read_capacity      = 10

  attribute {
    name = "RideId"
    type = "S"
  }

}