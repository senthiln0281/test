variable "region"{
  default = "us-west-2"
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