#!/bin/bash
IFS=$'\n'
for line in $(curl -s 'localhost:9200/_cat/shards' | fgrep UNASSIGNED); do
 INDEX=$(echo $line | (awk '{print $1}'))
 SHARD=$(echo $line | (awk '{print $2}'))
 #echo $INDEX
 curl -XDELETE localhost:9200/$INDEX
done
