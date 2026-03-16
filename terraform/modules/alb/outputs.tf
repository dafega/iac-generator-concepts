output "alb_arn" {
  value = aws_lb.this.arn
}

output "http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "security_group_id" {
  value = aws_security_group.alb.id
}

