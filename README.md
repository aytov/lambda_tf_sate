# lambda_tf_sate

Creates a Lambda function in Java that allows to retrieve an arbitrary terraform 
state file from S3 and return terraform outputs from the state file, such as the URL of an AWS application load 
balancer. The Lambda function is managed using Terraform IaC. By default all outputs
from the terraform state are returned and the function accepts an input JSONPath (https://jsonpath.com/) expression to return a 
specific output from the terraform state file.

## Prerequisites

* Java 11+
* Maven 3+
* aws-cli/2.2.26 
* Python/3.8.8

## Steps
1. Crate an S3 bucket with correct policy permissions for storing the terraform state. 
An example guide here: https://developer.hashicorp.com/terraform/language/settings/backends/s3
2. Go to `terraform/main.tf` and set the S3 bucket name from step 1.
3. Build the jar archive and provision the AWS env by running:
```
$ ./build_and_deploy.sh
```
4. This is the example call on how to get the `dns_name` for an AWS LoadBalancer.

    Payload:
    ```json
    {
      "exp": "$.resources[?(@.type == \"aws_lb\")].instances[*].attributes.dns_name"
    }
    ```
    AWS CLI command:
    ```
    aws lambda invoke --region eu-central-1 --function-name lambda_tf_sate --cli-binary-format raw-in-base64-out --payload file://payload.json out.txt
    ```
    Output:
    ```
    "[\"internal-lambda-terraform-state-dev-lb-1538278302.eu-central-1.elb.amazonaws.com\"]"
    ```
5. Clean up
```
$ ./destroy.sh
```
