provider "aws"{
  region = "${var.region}"
}
resource "aws_api_gateway_authorizer" "WildRydes" {
  name                   = "WildRydes"
  rest_api_id            = "${aws_api_gateway_rest_api.WildRydes.id}"
#  authorizer_uri         = "${aws_lambda_function.authorizer.invoke_arn}"
  authorizer_credentials = "${aws_iam_role.iam_for_lambda.name}"
}