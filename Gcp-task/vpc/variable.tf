variable "vpc_name" {
  type = string
}

variable "public_subnet_cidr1" {
  type = string
}

variable "public_subnet_cidr2" {
  type = string
}

variable "private_subnet_cidr1" {
  type = string
}

variable "private_subnet_cidr2" {
  type = string
}

variable "region" {
  type = string
}

variable "router_name" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "ssh_firewall_name" {
  type = string
}

variable "http_firewall_name" {
  type = string
}

variable "internal_firewall_name" {
  type = string
}