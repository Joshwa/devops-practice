#!/bin/bash

#Prints CPU usage
echo -e "\e[1mCPU Usage:\e[0m  [In use: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%]"

#Prints memory usage
mem_totl=$(vmstat -s | sed -n 1p | awk '{print $1}')
mem_used=$(vmstat -s | sed -n 2p | awk '{print $1}')
mem_free=$(bc -l <<< "$(vmstat -s | sed -n 4p | awk '{print $1}') + $(vmstat -s | sed -n 5p | awk '{print $1}')")
kb2gb=0.0000009536743

echo -e "\e[1mRAM Usage:\e[0m  [In use: "$(bc -l <<< "scale=1; $mem_used * $kb2gb / 1")" Gb ("$((bc -l <<< "scale=2; ($mem_used  / $mem_totl) * 100") | rev | cut -c4- | rev)"%) | Free: "\
$(bc -l <<< "scale=1; $mem_free * $kb2gb / 1")" Gb ("$((bc -l <<< "scale=2; ($mem_free  / $mem_totl) * 100") | rev | cut -c4- | rev)"%) | Total: "\
$(bc -l <<< "scale=1; $mem_totl * $kb2gb /1")" Gb]"

# Total disk usage
k2g() {
    echo $(bc -l <<< "scale=1; $1 * $kb2gb / 1")" Gb"
}

perc() {
    echo $((bc -l <<< "scale=2; ($1 / $disk_totl ) * 100")| rev | cut -c4- | rev)"%"
}

disk_used=$(df | tail | sed -n "$i"p | awk '{ total+=$3} END { print total }')
disk_free=$(df | tail | sed -n "$i"p | awk '{ total+=$4} END { print total }')
disk_totl=$(bc -l <<< "scale=1; $disk_used + $disk_free")

echo -e "\e[1mDisk Usage:\e[0m [In use: "$(k2g "$disk_used")" ("$(perc "$disk_used")") |"\
" Free: "$(k2g "$disk_free")" ("$(perc "$disk_free")") |"\
" Total: "$(k2g "$disk_totl")"]"

# Top 5 processes by CPU
echo
echo -e "\e[1mTop 5 processes by CPU usage:\e[0m"
ps aux --sort=-pcpu | head -n 6 | awk '{print $11}' | tail -5

#top 5 process by RAM usage
echo
echo -e "\e[1mTop 5 processes by RAM usage:\e[0m"
ps aux --sort=-rss | head -n 6 | awk '{print $11}' | tail -5