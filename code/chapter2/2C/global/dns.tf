# Configuring NameServers of DNS Zones created in Child Accounts
data "aws_route53_zone" "preconfigured_domain" {
  name = var.domain
}

# Create NS Records for dev route53 Zone
resource "aws_route53_record" "dev_ns" {
  zone_id = data.aws_route53_zone.preconfigured_domain.id
  name    = "dev.${var.domain}"
  type    = "NS"
  ttl     = "300"

  records = [
    module.dev.name_servers[0],
    module.dev.name_servers[1],
    module.dev.name_servers[2],
    module.dev.name_servers[3],
  ]
}

# Create NS Records for prod route53 Zone
resource "aws_route53_record" "prod_ns" {
  zone_id = data.aws_route53_zone.preconfigured_domain.id
  name    = "prod.${var.domain}"
  type    = "NS"
  ttl     = "300"

  records = [
    module.prod.name_servers[0],
    module.prod.name_servers[1],
    module.prod.name_servers[2],
    module.prod.name_servers[3],
  ]
}