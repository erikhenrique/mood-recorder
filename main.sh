#!/bin/bash


CONFIG_FILE_PREFIX=~/.mood-recorder/history
CONFIG_FILE_EXT=.txt
DATE_FORMAT="+%d/%m - %A"


help()
{
    echo '== This is the mood recorder =='
    echo 'usage:'
    echo '$ mood good "\e[3mCode Review time was improved\e[0m"'
    echo '$ mood improve "\e[3mFocus on technical debts\e[0m"'
    echo '$ mood tks \e[3m<name>\e[0m "\e[3mit was very funny our last pair!\e[0m"'
    echo '$ mood clear: Clean the whole history'
    echo '$ mood show: Shows all your moods'
}


recorder()
{
    echo "[$1] $2" >> "$CONFIG_FILE_PREFIX-$STATUS$CONFIG_FILE_EXT"
}


tks()
{
    echo "[$1] $2: $3" >> "$CONFIG_FILE_PREFIX-tks$CONFIG_FILE_EXT"
}


show()
{
    if [ -s "$CONFIG_FILE_PREFIX-good$CONFIG_FILE_EXT" ]; then
        echo "What was good? "
        cat "$CONFIG_FILE_PREFIX-good$CONFIG_FILE_EXT"
    fi
    if [ -s "$CONFIG_FILE_PREFIX-improve$CONFIG_FILE_EXT" ]; then
        echo ''
        echo "What we have to improve? "
        cat "$CONFIG_FILE_PREFIX-improve$CONFIG_FILE_EXT"
    fi
    if [ -s "$CONFIG_FILE_PREFIX-tks$CONFIG_FILE_EXT" ]; then
        echo ''
        echo 'Special thanks to:'
        cat "$CONFIG_FILE_PREFIX-tks$CONFIG_FILE_EXT"
    fi
}


clear()
{
    cat /dev/null > "$CONFIG_FILE_PREFIX-good$CONFIG_FILE_EXT"
    cat /dev/null > "$CONFIG_FILE_PREFIX-improve$CONFIG_FILE_EXT" 
    cat /dev/null > "$CONFIG_FILE_PREFIX-tks$CONFIG_FILE_EXT"
}


mood()
{
    STATUS=$1
    MENSAGEM=$2
    TIMESTAMP=$(date "$DATE_FORMAT")

    case "$STATUS" in
        "show")
            show
        ;;
        "clear")
            clear
        ;;
        "good")
            recorder $TIMESTAMP $MENSAGEM
        ;;
        "improve")
            recorder $TIMESTAMP $MENSAGEM
        ;;
        "tks")
            tks $TIMESTAMP $2 $3
        ;;
        "help")
            help
        ;;  
    esac
}

