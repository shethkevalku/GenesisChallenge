resource "aws_route53_zone" "private_hosted_zone" {
  name               = "genesis.internal"  
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "private_ip_record" {
  zone_id = aws_route53_zone.private_hosted_zone.zone_id 
  name    = "${var.application_name}-private"
  type    = "A"
  ttl     = 300

  records = var.instance_private_ips
}

resource "aws_route53_record" "load_balancer_dns_record" {
  zone_id = aws_route53_zone.private_hosted_zone.zone_id    
  name    = "${var.application_name}-loadbalancer"
  type    = "CNAME"
  ttl     = 300

  records = [var.load_balancer_dns]
}
