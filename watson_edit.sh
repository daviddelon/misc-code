#!/bin/bash
#set -x
# David Delon david.delon@clapas.net February 2022

function getframesbyday {
    i=0
    menu[i]="Add"
    menu[i+1]="Add a new task"
    ((i+=2))
    IFS=$'\n'
    for line in $(watson log -G)
    do
        line=`echo $line |tr -d "\t"` # Clean line
        frame=`echo $line |cut -d " " -f1` # Extract frame id
        if ! [[ $frame =~ [0-9][0-9]* ]] # frame id not found : it's a day entry
        then
          frame=""
          entry=$line
        else # frame id found : reformat line in order to display one frame id only
          entry=`echo $line | sed "s/$frame//g"`
        fi
        menu[i]=$frame
        menu[i+1]="$entry"
        ((i+=2))
    done
}


function getprojects {
    i=0
    IFS=$'\n'
    for line in $(watson projects)
    do
        menu[i]=$line
        menu[i+1]="$line"
        ((i+=2))
    done
}

function gettags {
    i=0
    IFS=$'\n'
    for line in $(watson tags)
    do
        menu[i]=$line
        menu[i+1]="$line"
        ((i+=2))
    done
}


export VISUAL=vi
while [ 1 ]
do
    menu=()
    getframesbyday 
    sel=$(whiptail --title "Watson log" --menu ""  ${#arr[@]} 50 ${#arr[@]}-8 "${menu[@]}"  3>&1 1>&2 2>&3)
    if [[ $? -gt 0 ]]
    then # user pressed <Cancel> button
        break
    fi
    # 
    if [[ $sel != "" ]]
    then
        if [[ $sel == "Add" ]]
        then
            menu=()
            getprojects
            sel=$(whiptail --title "Watson projects" --menu ""  ${#arr[@]} 50 ${#arr[@]}-8 "${menu[@]}"  3>&1 1>&2 2>&3)
            if [[ $? -gt 0 ]]
            then # user pressed <Cancel> button
                continue
            fi
            if [[ $sel != "" ]] # projet selected
            then
                project=$sel
                menu=()
                gettags
                sel=$(whiptail --title "Watson tags" --menu ""  ${#arr[@]} 50 ${#arr[@]}-8 "${menu[@]}"  3>&1 1>&2 2>&3)
                if [[ $? -gt 0 ]]
                then # user pressed <Cancel> button
                    continue
                fi
                if [[ $sel != "" ]] # tag selected
                then
                    tag=$sel
                    watson stop # stop current task ! 
                    watson start $project +$tag
                    watson stop 
                fi

            fi
        else # frame selected
           watson edit $sel
        fi
    fi
done
exit
