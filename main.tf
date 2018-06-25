provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/usr/bin/awscreds"
  profile                 = "customprofile"
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
