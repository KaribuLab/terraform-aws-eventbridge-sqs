resource "aws_cloudwatch_event_bus" "custom" {
  name = var.eventbus_name
}


resource "aws_cloudwatch_event_rule" "rules" {
  for_each = { for rule in var.rules : rule.name => rule }

  name           = each.value.name
  description    = lookup(each.value, "description", "")
  event_pattern  = each.value.event_pattern
  event_bus_name = aws_cloudwatch_event_bus.custom.name
}

resource "aws_cloudwatch_event_target" "targets" {
  for_each       = { for rule in var.rules : rule.name => rule }
  depends_on     = [aws_cloudwatch_event_bus.custom]
  rule           = each.value.name
  target_id      = "${each.value.name}-sqs"
  arn            = each.value.sqs_queue_arn
  event_bus_name = aws_cloudwatch_event_bus.custom.name
}

resource "aws_sqs_queue_policy" "eventbridge_access" {
  depends_on = [aws_cloudwatch_event_rule.rules]
  for_each   = { for rule in var.rules : rule.name => rule }

  queue_url = each.value.sqs_queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowEventBridgeSendMessage"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = each.value.sqs_queue_arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_cloudwatch_event_rule.rules[each.key].arn
          }
        }
      }
    ]
  })
}
