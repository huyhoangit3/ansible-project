# Here is the order of precedence for vars in the current version of Ansible
Vars set on the command line -e foo=set_on_cmd_line
Vars set in the vars_files: block in the play
Vars set in the vars: block in the play
Vars set in host_vars/
Vars set in group_vars/
Role default vars roles/.../defaults/main.yml
