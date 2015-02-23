#!/bin/sh
# brew install siege
siege -b -t5s -T "text/xml" -f sites.txt
siege -b -t5s http://localhost:4000/api/docunencrypted/1
