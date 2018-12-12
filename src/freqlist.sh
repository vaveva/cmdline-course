#! /bin/bash

tr '[A-Z]' '[a-z]' < $1

cat $1 |
tr -s '[:space:]' '\n' |
tr -d '[:punct:]' |
sort | 
uniq -c | 
sort -nr > $2
