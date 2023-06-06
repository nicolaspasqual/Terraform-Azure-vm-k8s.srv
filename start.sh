#!/bin/bash

rm ./ansible/hosts
cd ./terraform
terraform output public_ip_address_1 | sed 's/^"//' | sed 's/"$//' >> ../ansible/hosts
terraform output public_ip_address_2 | sed 's/^"//' | sed 's/"$//' >> ../ansible/hosts