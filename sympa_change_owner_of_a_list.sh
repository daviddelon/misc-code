#!/bin/bash
# Change owner of a sympa mailing list (assumes sympa is installed from source)
# Usage : change_owner_of_a_list.sh domain listname new_listmaster
domain=$1
list=$2
new_listmaster=$3
sudo sympa.pl --dump_users --list $list@$domain --role owner
sudo ex "/usr/local/var/lib/sympa/list_data/$domain/$list/owner.dump" << EOF
% s/email \S\+@\S\+/email $new_listmaster
wq
EOF
sudo sympa.pl --restore_users --list $list@$domain --role owner
