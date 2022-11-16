#!/usr/bin/env bash

printf 'Running terraform destroy ..\n\n'
cd terraform
terraform destroy
rm plan.out
