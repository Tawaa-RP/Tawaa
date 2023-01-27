#!/bin/bash

cd /home/eggdrop/eggdrop/chatlogs

for d in ./*/
do (/usr/bin/logs2html $d -t "The Archives" -p "Log archive for ${d/.\/}" -o /var/www/html/archive/$d)
done
