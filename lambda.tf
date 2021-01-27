resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy_for_lambda" {
  name        = "important_lambda_policy"
  path        = "/"
  description = "The main policy for our lambda role"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_lambda_function" "node-js-lambda" {

  # Let's assume for the purposes of this exercize that 
  # - the .zip file exists 
  # - has valid NodeJS code
  
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "exports.test"

  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "go1.x"

   vpc_config {
    subnet_ids = [
      aws_subnet.a.id,
      aws_subnet.b.id,
      aws_subnet.c.id,
    ]
    security_group_ids = [aws_security_group.allow_outgoing.id]
  }

  environment {
    variables = {
      DB_PASS = "password123"
    }
  }

}