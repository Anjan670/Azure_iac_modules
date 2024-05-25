variable "rg_var" {
  description = "Resource group details"
  type = object({
    name     = string
    location = string
  })
