variable "rg_var" {
  description = "Resource group details"
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    "one" = {
      name     = "rg1"
      location = "eastus"
    },
    "two" = {
      name     = "rg2"
      location = "westus"
    }
  }
}
