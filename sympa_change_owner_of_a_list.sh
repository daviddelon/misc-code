#!/bin/bash
domain=$1
list=$2
new_listmaster=$3
sudo sympa.pl --dump_users --list $list@$domain --role owner
sudo ex "/usr/local/var/lib/sympa/list_data/$domain/$list/owner.dump" << EOF
% s/email \S\+@\S\+/email $new_listmaster
wq
EOF
sudo sympa.pl --restore_users --list $list@$domain --role owner
