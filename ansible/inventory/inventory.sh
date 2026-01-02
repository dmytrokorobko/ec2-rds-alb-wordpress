#!/bin/bash

set -e

if [[ "$1" == "--list" ]]; then
   IPLIST=$(terraform -chdir="../terraform/02_compute" output -json wordpress_ec2_private_ip)
   jq -n --argjson ips "$IPLIST" '{
      servers: {
         hosts: $ips
      }
   }'
else
   echo "{}"
fi