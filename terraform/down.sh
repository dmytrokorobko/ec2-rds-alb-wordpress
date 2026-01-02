#!/bin/bash

terraform -chdir=./04_rds/ destroy
terraform -chdir=./03_alb/ destroy
terraform -chdir=./02_compute/ destroy
terraform -chdir=./01_network/ destroy
