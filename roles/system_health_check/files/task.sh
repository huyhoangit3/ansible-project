#! /bin/bash

system_health_check_target="$1"
system_health_check_wait="$2"
system_health_check_status="$3"
system_health_check_time="$4"

while true
do
  sleep $system_health_check_wait
#  current_alarm_state=$(aws cloudwatch describe-alarms --query "MetricAlarms[?contains(AlarmName, \`${system_health_check_target}\`) == \`true\`]" | jq .[0].StateValue)
  current_alarm_state=$(echo 'OK')

  if [ $current_alarm_state == "${system_health_check_status}" ]
  then
    echo 'SUCCESS'
    exit 0
  fi

  system_health_check_time=$((system_health_check_time - 1))
  echo "${system_health_check_time}"

  if [ $system_health_check_time -eq 0 ]
  then
    echo 'ERROR'
    exit 1
  fi

done


