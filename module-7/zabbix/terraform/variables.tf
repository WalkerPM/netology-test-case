variable "image_type" {
  description = "Type of image used for deployment"
  type        = string
  default     = "fd89n8278rhueakslujo" // Ubuntu 22.04
}
variable "centos_image_type" {
  description = "Type of centos image used for deployment"
  type        = string
  default     = "fd80le4b8gt2u33lvubr" // Centos 7
}
variable "current_zone" {
  description = "Used SSH keys"
  type        = string
  default     = "ru-central1-a" 
}
variable "token" {
  description = "private token for cloud"
  type        = string
}
variable "folder_id" {
  description = "used folder id"
  type        = string
}
variable "cloud_id" {
  description = "Used cloud id"
  type        = string
}
variable "cidr_block" {
  description = "Which CIDR block will be used for network"
  type        = string
  default = "192.168.10.0/24"
}
variable "inventory_path" {
  description = "Where will be stored ansible inventory file"
  type = string
  default = "../ansible/inventory.ini"
}
variable "ssh_key_path" {
  description = "Where will be stored SSH key for instances"
  type = string
  default = "../../keys/id_rsa.pub"
}
variable "ssh_privkey_path" {
  description = "Where will be stored SSH key for instances"
  type = string
  default = "../../keys/id_rsa"
}

