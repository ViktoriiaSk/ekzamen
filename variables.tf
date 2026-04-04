variable "pvt_key" {
  description = "Приватний SSH ключ для підключення до ВМ"
  sensitive   = true
}

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}
variable "spaces_access_key" { type = string }
variable "spaces_secret_key" { type = string }
