data "aws_lambda_function" "ion" {
  depends_on    = [var.dependencies]
  function_name = "${var.query_group_codedeploy_deployment_group}-${var.function_name}"
}

data "aws_iam_policy_document" "driver_access" {
  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
    ]

    resources = [var.driver_queue_arn]
  }
}

resource "aws_iam_policy" "driver_access" {
  name   = "${var.query_group_codedeploy_deployment_group}-${var.function_name}"
  policy = data.aws_iam_policy_document.driver_access.json
}

resource "aws_iam_role_policy_attachment" "driver_access" {
  policy_arn = aws_iam_policy.driver_access.arn
  role       = element(split("/", data.aws_lambda_function.ion.role), 1)
}

resource "aws_lambda_event_source_mapping" "driver" {
  event_source_arn = var.driver_queue_arn
  enabled          = true
  function_name    = data.aws_lambda_function.ion.function_name
}
