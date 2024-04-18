variable "appname" {
  type    = string
  default = "ngress"
}
variable "env" {
  type    = string
  default = "dev"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "pyapp"
}
variable "internal" {
  type    = bool
  default = false
}
variable "type" {
  type    = string
  default = "application"
}
