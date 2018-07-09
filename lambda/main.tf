provider "aws"{
  region = "${var.region}"
}
resource "aws_lambda_function" "RequestUnicorn" {
#  filename         = "requestunicorn.zip"
  function_name    = "requestunicorn"
  role             = "arn:aws:iam::033219852540:role/WildRydesLambda"
  handler          = "requestunicorn"
  runtime          = "python2.7"
  s3_bucket = "wildrydes-senthil-497704"
  s3_key = "requestunicorn.zip"
}