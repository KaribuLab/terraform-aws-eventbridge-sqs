variable "eventbus_name" {
  description = "Nombre del eventbus"
  type        = string
}

variable "rules" {
  description = "Lista de reglas a crear con sus colas y patrones"
  type = list(object({
    name                = string
    description         = optional(string)
    event_pattern       = string
    sqs_queue_arn       = string
    sqs_queue_url       = string
  }))
}

variable "tags" {
  description = "Tags aplicados a cada regla"
  type        = map(string)
}
