#!/bin/bash
i=1 n=0
rsstail -i 60 -n 1 -u https://tawaa-rp.net/rss --format 'New Post: %(title)s | Link: %(link)s\n' | while read line
do
((n >= i )) && rss.sh "$line"
((n++))
done
