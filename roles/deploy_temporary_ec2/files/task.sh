#!/bin/bash

deploy_temporary_ec2_target_asg="$1"
deploy_temporary_ec2_wait_limit="$2"

aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${deploy_temporary_ec2_target_asg} > result.json

ec2_instance_id=$(jq .AutoScalingGroups[0].Instances[0].InstanceId result.json)
asg_template_name=$(jq .AutoScalingGroups[0].LaunchTemplate[0].LaunchTemplateName result.json)
asg_template_id=$(jq .AutoScalingGroups[0].LaunchTemplate[0].LaunchTemplateId result.json)

ami_id=$(aws ec2 describe-instances --instance-ids ${ec2_instance_id} | jq .Reservations[0].Instances[0.ImageId])

while true
do
  sleep $system_health_check_wait
  current_alarm_state=$(aws cloudwatch describe-alarms  --alarm-names ${system_health_check_target} | jq .MetricAlarms[0].StateValue)

  if [[ "$current_alarm_state" == "$system_health_check_status" ]];
  then
    echo 'SUCCESS'
    exit 0
  fi

  system_health_check_time=$((system_health_check_time - 1))
  echo "${system_health_check_time}"

  if [ $system_health_check_time -eq 0 ];
  then
    echo 'ERROR'
    exit 1
  fi

done


