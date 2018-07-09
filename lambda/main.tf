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
resource "aws_lambda_function" "RequestUnicorn" {
#  filename         = "requestunicorn.zip"
  function_name    = "requestunicorn"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "requestunicorn"
  runtime          = "python2.7"
  s3_bucket = "wildrydes-senthil-497704"
  s3_key = "requestunicorn.zip"
}