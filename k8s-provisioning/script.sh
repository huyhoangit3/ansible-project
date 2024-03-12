#! /bin/bash
ENV="$1"
KEY_NAME="$2"

ANSIBLE_CONFIG="../ansible.cfg"

export ENV
export KEY_NAME
export ANSIBLE_CONFIG

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --key-file "~/.ssh/$KEY_NAME.pem" -i ~/ansible/inventory/hosts -T 300 ~/ansible/playbook.yaml
