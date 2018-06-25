variable "region"{
  default = "us-west-2"
}
variable "bucket" {
  default = "wildrydes-senthil-497704"
  count = 2
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