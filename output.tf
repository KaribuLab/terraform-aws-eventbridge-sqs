output "eventbus_arn" {
  value = aws_cloudwatch_event_bus.custom.arn
}

output "rule_arns" {
  value = {
    for k, r in aws_cloudwatch_event_rule.rules : k => r.arn
  }
}
