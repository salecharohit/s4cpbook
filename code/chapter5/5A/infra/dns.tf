// Pseudo Code
//if(environment==prod){
//     url = prod.$domain
// }elseif(environment==dev){
//     url = dev.$domain
// }
locals {

  prod_url = var.environment == "prod" ? "prod.${var.domain}" : ""
  dev_url  = var.environment == "dev" ? "dev.${var.domain}" : ""

  url = coalesce(local.prod_url, local.dev_url)

}


# Fetch the Zone ID of the hosted domains
data "aws_route53_zone" "domain" {
  name = "${local.url}."

}

# Generate Certificate for the particular domain

module "acm" {

  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = local.url
  zone_id     = data.aws_route53_zone.domain.zone_id

  wait_for_validation = true

  tags = {
    Name = local.url
  }
}

# Fetching the ZoneID for ELB
data "aws_elb_hosted_zone_id" "main" {}

# Mapping The Ingress controller hostname with DNS Record
resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = local.url
  type    = "A"

  alias {
    name                   = kubernetes_ingress_v1.app.status.0.load_balancer.0.ingress.0.hostname
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }

  depends_on = [module.alb_ingress, kubernetes_ingress_v1.app]

}