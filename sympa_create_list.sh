#!/bin/bash
# Create sympa list on command line, with template xml

# define parameters which are passed in.
TYPE=$1
DOMAIN=$2
LISTNAME=$3
CONTACT=$4


#define the template.
cat  << EOF > /tmp/tmpfile.xml
<?xml version="1.0" ?>
<list>
<listname>$LISTNAME</listname>
<type>$TYPE</type>
<subject>$LISTNAME</subject>
<description>$LISTNAME</description>
<status>open</status>
<shared_edit>editor</shared_edit>
<shared_read>private</shared_read>
<language>fr</language>
<owner>
<email>$CONTACT</email>
</owner>
<topic>Abonnes</topic>
</list>
EOF

sudo sympa.pl --debug --create_list --robot=$DOMAIN --input_file=/tmp/tmpfile.xml
