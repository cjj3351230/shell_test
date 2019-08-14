#!/bin/bash
sed -n 'p' /etc/passwd | awk -F: '{print "Hello "$1" and your id is "$3}'
