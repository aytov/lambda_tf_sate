#!/usr/bin/env bash

printf 'Executing the lambda ..\n\n'
aws lambda invoke --region eu-central-1 --function-name lambda_tf_sate --cli-binary-format raw-in-base64-out --payload file://payload.json out.txt
printf '\n\n Output is:\n'
cat out.txt
