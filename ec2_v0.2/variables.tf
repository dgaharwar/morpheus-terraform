variable "morpheus_url" {
  type        = string
  description = "The URL of the Morpheus Data Appliance where requests will be directed."
}  

# variable "morpheus_access_token" {
#   type        = string
#   description = "Access Token of Morpheus user. This can be used instead of authenticating with Username and Password."
# }
variable "tenant_subdomain" {
  type        = string
  description = "Subtenant ID name"
}