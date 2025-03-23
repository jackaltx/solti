#!/bin/bash
# Simple IPv6 and Service Connection Check
OUTPUT_DIR="/tmp/server-connections"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/connections-$(date +%Y%m%d%H%M%S).txt"

echo "IPv6 and Service Connection Analysis - $(date)" > "$OUTPUT_FILE"
echo "=======================================" >> "$OUTPUT_FILE"

# Check IPv6 configuration
echo -e "\n## IPv6 CONFIGURATION" >> "$OUTPUT_FILE"
echo "----------------------" >> "$OUTPUT_FILE"
echo "IPv6 Addresses:" >> "$OUTPUT_FILE"
ip -6 addr show | grep "inet6" >> "$OUTPUT_FILE"

echo -e "\nIPv6 Listening Services:" >> "$OUTPUT_FILE"
ss -6 -tulpn | grep LISTEN >> "$OUTPUT_FILE"

echo -e "\nIPv6 Firewall Rules:" >> "$OUTPUT_FILE"
ip6tables -L -n >> "$OUTPUT_FILE" 2>&1

# Check service connections
echo -e "\n## SERVICE CONNECTIONS" >> "$OUTPUT_FILE"
echo "----------------------" >> "$OUTPUT_FILE"
echo "Active Connections:" >> "$OUTPUT_FILE"
ss -tuap | grep ESTAB >> "$OUTPUT_FILE"

echo -e "\nUnix Socket Connections:" >> "$OUTPUT_FILE"
ss -xap >> "$OUTPUT_FILE"

echo -e "\nProcesses with Network Connections:" >> "$OUTPUT_FILE"
netstat -tulpn | awk '{print $7}' | grep "/" | sort | uniq -c | sort -nr >> "$OUTPUT_FILE"

echo -e "\nExploration completed at $(date)" >> "$OUTPUT_FILE"
echo "Results saved to $OUTPUT_FILE"
