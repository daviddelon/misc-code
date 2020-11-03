#!/bin/bash
# List mailing lists of a domain and change their owner
# Usage : sympa_change_owner_of_domain.sh domain new_list_master (assumes sympa installed from source)
domain=$1
new_listmaster=$2

for list in `sudo ls /usr/local/var/lib/sympa/list_data/$domain`
do
   sh sympa_change_owner_of_a_list.sh $domain $list $new_listmaster
done
