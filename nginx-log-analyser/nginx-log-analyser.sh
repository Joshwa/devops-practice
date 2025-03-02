#!/bin/bash

getcount() {
    column=$1
    cat ./nginx-access.log | awk '{print '$column'}' | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2, "-", $1, "requests"}'
    echo
}

ip_address='$1'
request_path='$7'
response_code='$9'

echo -e "\e[1mTop 5 IP addresses with the most requests:\e[0m"
getcount "$ip_address"
echo -e "\e[1mTop 5 most requested paths:\e[0m"
getcount "$request_path"
echo -e "\e[1mTop 5 response status codes:\e[0m"
getcount "$response_code"