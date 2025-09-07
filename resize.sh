#!/bin/bash

show_help() {
    echo "Usage: $0 -d dirPath"
    echo
    echo "   -d      Specify the directory path"
    echo "   -h      Display this help message"
}

dirPath=""
while getopts ":d:h" opt; do
    case ${opt} in
        d )
            dirPath=$OPTARG
            ;;
        h )
            show_help
            exit 0
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
        : )
            echo "Invalid option: -$OPTARG requires an argument" >&2
            show_help
            exit 1
            ;;
    esac
done

shift $((OPTIND -1))

for img in "$dirPath"/*; do
  echo 'processing '"$img"'...'
  mogrify -resize 1920 "$dirPath"'/'$(basename "$img")
  echo 'overwriting '"$img"'...'
done
