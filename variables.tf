variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
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