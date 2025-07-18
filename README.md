# terraform-aws-eventbridge-sqs

Este módulo de Terraform crea reglas de EventBridge que envían eventos a colas SQS, permitiendo la integración de eventos personalizados en AWS.

## Variables de entrada

| Nombre            | Descripción                                      | Tipo                              | Requerido |
| ----------------- | ------------------------------------------------ | --------------------------------- | --------- |
| `eventbus_name`   | Nombre del eventbus                              | string                            | Sí        |
| [`rules`](#rules) | Lista de reglas a crear con sus colas y patrones | [list(object)](#definicion-rules) | Sí        |
| `tags`            | Tags aplicados a cada regla                      | map(string)                       | No        |

### Definición de objetos

#### rules

| Campo         | Descripción                | Tipo   | Requerido |
| ------------- | -------------------------- | ------ | --------- |
| name          | Nombre de la regla         | string | Sí        |
| description   | Descripción de la regla    | string | No        |
| event_pattern | Patrón de eventos (JSON)   | string | Sí        |
| sqs_queue_arn | ARN de la cola SQS destino | string | Sí        |
| sqs_queue_url | URL de la cola SQS destino | string | Sí        |

## Outputs

| Nombre        | Descripción                                       | Tipo                |
| ------------- | ------------------------------------------------- | ------------------- |
| `eventbus_arn`| ARN del eventbus creado                           | string              |
| `eventbus_name`| Nombre del eventbus creado                       | string              |
| `rule_arns`   | Mapa de ARNs de las reglas creadas (key: nombre)  | map(string)         |
