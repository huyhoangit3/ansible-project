#!/bin/bash

system_health_check_target="$1"
system_health_check_wait="$2"
system_health_check_status='"'"$3"'"'
system_health_check_time="$4"

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


