#!/bin/bash

terraform -chdir=./01_network/ apply
terraform -chdir=./02_compute/ apply
terraform -chdir=./03_alb/ apply
terraform -chdir=./04_rds/ apply