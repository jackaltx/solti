#!/bin/bash
#
# ISPConfig System Deep Exploration Script
# Gathers detailed information about an ISPConfig server for further analysis

# Set output file
OUTPUT_DIR="/tmp/server-exploration"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/server-details-$(date +%Y%m%d%H%M%S).txt"

echo "ISPConfig Server Deep Exploration - $(date)" > "$OUTPUT_FILE"
echo "==================================================" >> "$OUTPUT_FILE"

# System info
echo -e "\n## SYSTEM INFORMATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "Hostname: $(hostname)" >> "$OUTPUT_FILE"
echo "Kernel: $(uname -r)" >> "$OUTPUT_FILE"
echo "OS: $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)" >> "$OUTPUT_FILE"
echo "CPU: $(grep "model name" /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^[ \t]*//')" >> "$OUTPUT_FILE"
echo "Memory: $(free -h | grep "Mem:" | awk '{print $2}')" >> "$OUTPUT_FILE"
echo "Uptime: $(uptime -p)" >> "$OUTPUT_FILE"

# Disk usage
echo -e "\n## DISK USAGE" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
df -h >> "$OUTPUT_FILE"

# Network configuration
echo -e "\n## NETWORK CONFIGURATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "IP Addresses:" >> "$OUTPUT_FILE"
ip -4 addr show | grep inet | awk '{print $2}' >> "$OUTPUT_FILE"

# Apache virtual hosts
echo -e "\n## APACHE VIRTUAL HOSTS" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "Number of virtual hosts: $(ls -l /etc/apache2/sites-enabled/ | grep -v "^total" | wc -l)" >> "$OUTPUT_FILE"
echo "Enabled virtual hosts:" >> "$OUTPUT_FILE"
ls -l /etc/apache2/sites-enabled/ | grep -v "^total" | awk '{print $9}' >> "$OUTPUT_FILE"

# Apache modules
echo -e "\n## APACHE MODULES" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
apache2ctl -M | sort >> "$OUTPUT_FILE"

# PHP configuration
echo -e "\n## PHP CONFIGURATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
for phpver in $(ls -1 /usr/bin/php? /usr/bin/php?? 2>/dev/null); do
  VERSION=$($phpver -v 2>/dev/null | head -n1)
  if [ ! -z "$VERSION" ]; then
    echo -e "\n$VERSION" >> "$OUTPUT_FILE"
    echo "Memory limit: $($phpver -i | grep memory_limit | awk '{print $3}')" >> "$OUTPUT_FILE"
    echo "Max execution time: $($phpver -i | grep max_execution_time | awk '{print $3}')" >> "$OUTPUT_FILE"
    echo "Upload max filesize: $($phpver -i | grep upload_max_filesize | awk '{print $3}')" >> "$OUTPUT_FILE"
    echo "Modules:" >> "$OUTPUT_FILE"
    $phpver -m | grep -v "\[" | sort >> "$OUTPUT_FILE"
  fi
done

# MySQL databases
echo -e "\n## MYSQL DATABASES" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "Number of databases: $(mysql -Ns -e 'SHOW DATABASES;' | grep -v "information_schema" | grep -v "performance_schema" | grep -v "mysql" | wc -l)" >> "$OUTPUT_FILE"
echo "Databases:" >> "$OUTPUT_FILE"
mysql -Ns -e 'SHOW DATABASES;' | grep -v "information_schema" | grep -v "performance_schema" | grep -v "mysql" >> "$OUTPUT_FILE"

# Mail domains
echo -e "\n## MAIL CONFIGURATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
if [ -f "/etc/postfix/mysql-virtual_domains.cf" ]; then
  echo "Mail configuration type: ISPConfig managed (MySQL)" >> "$OUTPUT_FILE"
  if command -v postconf &>/dev/null; then
    echo "Mail hostname: $(postconf -h myhostname)" >> "$OUTPUT_FILE"
    echo "Mail protocols:" >> "$OUTPUT_FILE"
    postconf -n | grep "protocols =" >> "$OUTPUT_FILE"
  fi
fi

# Check for RBLs in Postfix config
echo "RBL configuration:" >> "$OUTPUT_FILE"
postconf -n | grep "reject_rbl" >> "$OUTPUT_FILE"

# Dovecot config
echo "Dovecot auth mechanisms:" >> "$OUTPUT_FILE"
grep "auth_mechanisms" /etc/dovecot/conf.d/10-auth.conf >> "$OUTPUT_FILE"

# DNS zones
echo -e "\n## DNS ZONES" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
if [ -d "/etc/bind" ] && [ -f "/etc/bind/named.conf.local" ]; then
  echo "Number of zones: $(grep -c "zone " /etc/bind/named.conf.local)" >> "$OUTPUT_FILE"
  echo "DNS zones:" >> "$OUTPUT_FILE"
  grep "zone " /etc/bind/named.conf.local | awk '{print $2}' | tr -d '\"' >> "$OUTPUT_FILE"
fi

# FTP configuration
echo -e "\n## FTP CONFIGURATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
if [ -f "/etc/pure-ftpd/pure-ftpd.conf" ]; then
  echo "FTP configuration: Pure-FTPd" >> "$OUTPUT_FILE"
  echo "TLS enabled: $(grep -c "TLS" /etc/pure-ftpd/pure-ftpd.conf)" >> "$OUTPUT_FILE"
  echo "Passive ports: $(grep "PassivePortRange" /etc/pure-ftpd/pure-ftpd.conf)" >> "$OUTPUT_FILE"
fi

# Cron jobs
echo -e "\n## SCHEDULED TASKS" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "System cron jobs:" >> "$OUTPUT_FILE"
ls -l /etc/cron.d/ | grep -v "^total" | awk '{print $9}' >> "$OUTPUT_FILE"

# ISPConfig details
echo -e "\n## ISPCONFIG DETAILS" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
if [ -d "/usr/local/ispconfig" ]; then
  echo "ISPConfig installed: Yes" >> "$OUTPUT_FILE"
  if [ -f "/usr/local/ispconfig/server/lib/config.inc.php" ]; then
    ISPCONFIG_VERSION=$(grep -E "ISPC_APP_VERSION" /usr/local/ispconfig/server/lib/config.inc.php | cut -d"'" -f4)
    echo "ISPConfig version: $ISPCONFIG_VERSION" >> "$OUTPUT_FILE"
  fi
  echo "ISPConfig services:" >> "$OUTPUT_FILE"
  ls -l /usr/local/ispconfig/server/server.php >> "$OUTPUT_FILE" 2>/dev/null
  echo "Web interface: $(grep "^document" /etc/apache2/sites-enabled/*ispconfig* 2>/dev/null)" >> "$OUTPUT_FILE"
fi

# Security configuration
echo -e "\n## SECURITY CONFIGURATION" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "Fail2ban jails:" >> "$OUTPUT_FILE"
fail2ban-client status 2>/dev/null | grep "Jail list" | sed 's/^.*://g' >> "$OUTPUT_FILE"

echo "Firewall status:" >> "$OUTPUT_FILE"
ufw status >> "$OUTPUT_FILE" 2>/dev/null || iptables -L -n | grep -v "^Chain" | grep -v "^target" | grep -v "^$" >> "$OUTPUT_FILE"

# SSL certificates
echo -e "\n## SSL CERTIFICATES" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
if [ -d "/etc/letsencrypt/live" ]; then
  echo "Let's Encrypt certificates:" >> "$OUTPUT_FILE"
  ls -l /etc/letsencrypt/live/ | grep -v "^total" | awk '{print $9}' >> "$OUTPUT_FILE"
elif [ -d "/usr/local/ispconfig/interface/ssl" ]; then
  echo "ISPConfig SSL certificates:" >> "$OUTPUT_FILE"
  ls -l /usr/local/ispconfig/interface/ssl/ | grep -v "^total" | awk '{print $9}' >> "$OUTPUT_FILE"
fi

# Resource usage
echo -e "\n## RESOURCE USAGE" >> "$OUTPUT_FILE"
echo "-------------------------" >> "$OUTPUT_FILE"
echo "Top 10 processes by CPU:" >> "$OUTPUT_FILE"
ps aux --sort=-%cpu | head -11 >> "$OUTPUT_FILE"
echo -e "\nTop 10 processes by memory:" >> "$OUTPUT_FILE"
ps aux --sort=-%mem | head -11 >> "$OUTPUT_FILE"

# Final message
echo -e "\nExploration completed at $(date)" >> "$OUTPUT_FILE"
echo "Results saved to $OUTPUT_FILE"
echo "You can analyze this file to get detailed information about the server configuration."
