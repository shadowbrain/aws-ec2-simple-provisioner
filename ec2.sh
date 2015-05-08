#!/bin/bash


# setup the environment and grab the arguments

export LANG=C

USAGE='Usage: ec2.sh <app_name> <environment> <number_of_instances> <instance_size>'

[[ ${#1} -gt 0 ]] && app="$1" || (echo $USAGE;exit 1)

[[ ${#2} -gt 0 ]] && envmnt="$2" || (echo $USAGE;exit 1)

[[ ${#3} -gt 0 ]] && numInst="$3" || (echo $USAGE;exit 1)

[[ ${#4} -gt 0 ]] && sizeInst="$4" || (echo $USAGE;exit 1)


# launch new Ubuntu 14.04 LTS x64 instances

aws ec2 run-instances --image-id ami-5189a661 --count $numInst --instance-type $sizeInst --key-name devops-test --security-groups $envmnt >> ./ec2-script.log

#FIXME: should only look for the new instances
#aws ec2 wait instance-running --filter Name=instance-type,Values=$sizeInst


# Get new instances info

#FIXME: should only include the newly created instances
sleep 5
aws ec2 describe-instances | grep -e "LaunchTime" -e "InstanceId" -e "PublicIpAddress"

# Run ansible on the new instances

ansible-playbook dev.yml
