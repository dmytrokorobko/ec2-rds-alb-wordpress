data "http" "get_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  my_ip = chomp(data.http.get_ip.response_body)
}