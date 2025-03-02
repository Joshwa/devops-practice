#!/bin/bash

getcount() {
    column=$1
    cat ./nginx-access.log | awk '{print '$column'}' | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2, "-", $1, "requests"}'
    echo
}

ip_address='$1'
request_path='$7'
response_code='$9'

echo "Top 5 IP addresses with the most requests:"
getcount "$ip_address"
echo "Top 5 most requested paths:"
getcount "$request_path"
echo "Top 5 response status codes:"
getcount "$response_code"