variable "env" {
  type        = string
  description = "Location to deploy the resource"
  default     = "k8s"
}

variable "location" {
  type        = string
  description = "Location to deploy the resource"
  default     = "Brazil South"
}

variable "pv-key" {
  type        = string
  description = "Location to deploy the resource"
  default     = "~/.ssh/id_rsa"
}

variable "pub-key" {
  type        = string
  description = "Location to deploy the resource"
  default     = "~/.ssh/id_rsa.pub"
}

