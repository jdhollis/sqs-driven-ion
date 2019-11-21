# sqs-driven-ion

A module for creating an SQS-driven [Datomic Ion](https://docs.datomic.com/cloud/ions/ions.html).

Usage:

```hcl
module "ion_function" {
  source = "github.com/jdhollis/sqs-driven-ion"

  dependencies                            = [module.query_group.ions]
  driver_queue_arn                        = aws_sqs_queue.driver_queue.arn
  function_name                           = "ion-function-name"
  query_group_codedeploy_deployment_group = module.query_group.codedeploy_deployment_group
}
```
