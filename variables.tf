variable "region"{
  default = "us-west-2"
}
variable "accountId"{
  default = "033219852540"
}
variable "bucket" {
  default = "wildrydes-senthil-497704"
}
variable "source" {
  default = "/usr/bin/terratest"
}
variable "etag" {
  default = "wildrydesimage"
}
variable "acl" {
  default = "public-read"
}
variable "aws_dynamodb_table" {
  default = "Rides"
}
variable "hash_key" {
  default = "RideId"
}
variable "range_key" {
  default = "RideTitle"
}
variable "aws_iam_role" {
  default = "WildRydesLambda"
}
variable "aws_iam_policy" {
  default = "DynamoDBWriteAccess"
}
variable "function_name" {
  default = "requestunicorn"
}
variable "api" {
  default = "WildRydes"
}