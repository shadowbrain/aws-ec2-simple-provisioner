#!/bin/bash

# setup the environment and grab the arguments

export LANG=C

USAGE='Usage: ec2.sh <app_name> <environment> <number_of_instances> <instance_size>'

[[ ${#1} -gt 0 ]] && app="$1" || echo $USAGE

[[ ${#2} -gt 0 ]] && envmnt="$2" || echo $USAGE

[[ ${#3} -gt 0 ]] && numInst="$3" || echo $USAGE

[[ ${#4} -gt 0 ]] && sizeInst="$4" || echo $USAGE

# launch new Ubuntu 14.04 LTS x64 instances

aws ec2 run-instances --image-id ami-5189a661 --count $numInst --instance-type $sizeInst --key-name devops-test --security-groups $envmnt


