#!/bin/bash
#
# BOM Verification Script for ISPConfig Server
# This script checks for the presence and status of components in the Software BOM

# Set output colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Create output directory if it doesn't exist
OUTPUT_DIR="/tmp/bom-verification"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/bom-verification-$(date +%Y%m%d%H%M%S).txt"

echo "Starting BOM verification at $(date)" | tee -a "$OUTPUT_FILE"
echo "=================================" | tee -a "$OUTPUT_FILE"

# Function to check if a package is installed
check_package() {
    if dpkg -l | grep -q " $1 "; then
        echo -e "${GREEN}[INSTALLED]${NC} Package $1" | tee -a "$OUTPUT_FILE"
        return 0
    else
        echo -e "${RED}[MISSING]${NC} Package $1" | tee -a "$OUTPUT_FILE"
        return 1
    fi
}

# Function to check if a service is running
check_service() {
    if systemctl is-active --quiet "$1"; then
        echo -e "${GREEN}[RUNNING]${NC} Service $1" | tee -a "$OUTPUT_FILE"
        return 0
    else
        if systemctl list-unit-files | grep -q "$1.service"; then
            echo -e "${RED}[STOPPED]${NC} Service $1" | tee -a "$OUTPUT_FILE"
        else
            echo -e "${RED}[NOT FOUND]${NC} Service $1" | tee -a "$OUTPUT_FILE"
        fi
        return 1
    fi
}

# Function to get package version
get_version() {
    if check_package "$1" > /dev/null; then
        VERSION=$(dpkg -l "$1" | grep "$1" | awk '{print $3}')
        echo -e "${YELLOW}[VERSION]${NC} $1: $VERSION" | tee -a "$OUTPUT_FILE"
    fi
}

# Check core services
echo -e "\n## Core Services" | tee -a "$OUTPUT_FILE"
echo "----------------" | tee -a "$OUTPUT_FILE"

# MySQL/MariaDB
check_service "mysql" || check_service "mariadb"
if [ $? -eq 0 ]; then
    get_version "mariadb-server" || get_version "mysql-server"
    echo "MySQL/MariaDB version:" | tee -a "$OUTPUT_FILE"
    mysql --version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# Apache
check_service "apache2"
if [ $? -eq 0 ]; then
    get_version "apache2"
    echo "Apache version:" | tee -a "$OUTPUT_FILE"
    apache2 -v 2>> "$OUTPUT_FILE" | head -n1 | tee -a "$OUTPUT_FILE"
fi

# Postfix
check_service "postfix"
if [ $? -eq 0 ]; then
    get_version "postfix"
    echo "Postfix version:" | tee -a "$OUTPUT_FILE"
    postconf -d mail_version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# Dovecot
check_service "dovecot"
if [ $? -eq 0 ]; then
    get_version "dovecot-core"
    echo "Dovecot version:" | tee -a "$OUTPUT_FILE"
    dovecot --version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# Bind9
check_service "bind9" || check_service "named"
if [ $? -eq 0 ]; then
    get_version "bind9"
    echo "Bind9 version:" | tee -a "$OUTPUT_FILE"
    named -v 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# Pure-FTPd
check_service "pure-ftpd" || check_service "pure-ftpd-mysql"
if [ $? -eq 0 ]; then
    get_version "pure-ftpd-common"
fi

# ClamAV
check_service "clamav-daemon"
if [ $? -eq 0 ]; then
    get_version "clamav"
    echo "ClamAV version:" | tee -a "$OUTPUT_FILE"
    clamdscan --version 2>> "$OUTPUT_FILE" | head -n1 | tee -a "$OUTPUT_FILE"
fi

# Rspamd
check_service "rspamd"
if [ $? -eq 0 ]; then
    get_version "rspamd"
    echo "Rspamd version:" | tee -a "$OUTPUT_FILE"
    rspamd -v 2>> "$OUTPUT_FILE" | head -n1 | tee -a "$OUTPUT_FILE"
fi

# Redis
check_service "redis-server"
if [ $? -eq 0 ]; then
    get_version "redis-server"
    echo "Redis version:" | tee -a "$OUTPUT_FILE"
    redis-cli --version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# Fail2ban
check_service "fail2ban"
if [ $? -eq 0 ]; then
    get_version "fail2ban"
    echo "Fail2ban version:" | tee -a "$OUTPUT_FILE"
    fail2ban-client --version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
fi

# PHP Environment
echo -e "\n## PHP Environment" | tee -a "$OUTPUT_FILE"
echo "----------------" | tee -a "$OUTPUT_FILE"

# PHP versions
echo "Installed PHP versions:" | tee -a "$OUTPUT_FILE"
ls -1 /usr/bin/php* | grep -E 'php[0-9]+\.[0-9]+$' | while read php_bin; do
    VERSION=$($php_bin -v 2>/dev/null | head -n1)
    if [ ! -z "$VERSION" ]; then
        echo -e "${GREEN}[FOUND]${NC} $php_bin: $VERSION" | tee -a "$OUTPUT_FILE"
    fi
done

# PHP-FPM instances
echo "PHP-FPM services:" | tee -a "$OUTPUT_FILE"
systemctl list-units --type=service | grep -E 'php[0-9]+\.[0-9]+-fpm' | while read -r line; do
    SERVICE=$(echo "$line" | awk '{print $1}')
    if systemctl is-active --quiet "$SERVICE"; then
        echo -e "${GREEN}[RUNNING]${NC} $SERVICE" | tee -a "$OUTPUT_FILE"
    else
        echo -e "${RED}[STOPPED]${NC} $SERVICE" | tee -a "$OUTPUT_FILE"
    fi
done

# Web Applications
echo -e "\n## Web Applications" | tee -a "$OUTPUT_FILE"
echo "----------------" | tee -a "$OUTPUT_FILE"

# phpMyAdmin
if [ -d "/usr/share/phpmyadmin" ] || [ -d "/var/www/phpmyadmin" ]; then
    echo -e "${GREEN}[FOUND]${NC} phpMyAdmin" | tee -a "$OUTPUT_FILE"
    # Try to get version from README or VERSION files
    if [ -f "/usr/share/phpmyadmin/README" ]; then
        PMA_VERSION=$(grep -i "version" /usr/share/phpmyadmin/README | head -n1)
        echo "phpMyAdmin: $PMA_VERSION" | tee -a "$OUTPUT_FILE"
    fi
else
    echo -e "${RED}[NOT FOUND]${NC} phpMyAdmin" | tee -a "$OUTPUT_FILE"
fi

# Roundcube
if [ -d "/usr/share/roundcube" ] || [ -d "/var/www/roundcube" ]; then
    echo -e "${GREEN}[FOUND]${NC} Roundcube" | tee -a "$OUTPUT_FILE"
    # Try to get version from package
    get_version "roundcube"
else
    echo -e "${RED}[NOT FOUND]${NC} Roundcube" | tee -a "$OUTPUT_FILE"
fi

# acme.sh
if [ -f "/root/.acme.sh/acme.sh" ]; then
    echo -e "${GREEN}[FOUND]${NC} acme.sh" | tee -a "$OUTPUT_FILE"
    echo "acme.sh version:" | tee -a "$OUTPUT_FILE"
    /root/.acme.sh/acme.sh --version 2>> "$OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
else
    echo -e "${RED}[NOT FOUND]${NC} acme.sh" | tee -a "$OUTPUT_FILE"
fi

# ISPConfig
echo -e "\n## ISPConfig" | tee -a "$OUTPUT_FILE"
echo "----------------" | tee -a "$OUTPUT_FILE"

if [ -d "/usr/local/ispconfig" ]; then
    echo -e "${GREEN}[FOUND]${NC} ISPConfig installation directory" | tee -a "$OUTPUT_FILE"
    # Try to get version
    if [ -f "/usr/local/ispconfig/server/lib/config.inc.php" ]; then
        ISPCONFIG_VERSION=$(grep -E "ISPC_APP_VERSION" /usr/local/ispconfig/server/lib/config.inc.php | cut -d"'" -f4)
        echo "ISPConfig version: $ISPCONFIG_VERSION" | tee -a "$OUTPUT_FILE"
    fi
else
    echo -e "${RED}[NOT FOUND]${NC} ISPConfig" | tee -a "$OUTPUT_FILE"
fi

# Check ISPConfig services
if [ -d "/usr/local/ispconfig" ]; then
    echo "ISPConfig services:" | tee -a "$OUTPUT_FILE"
    check_service "apache2"
    check_service "mysql" || check_service "mariadb"
fi

# Network Ports
echo -e "\n## Network Ports" | tee -a "$OUTPUT_FILE"
echo "----------------" | tee -a "$OUTPUT_FILE"
echo "Listening ports:" | tee -a "$OUTPUT_FILE"
netstat -tulpn 2>/dev/null | grep LISTEN | sort -n -k 4 | tee -a "$OUTPUT_FILE" || ss -tulpn | grep LISTEN | sort -n -k 5 | tee -a "$OUTPUT_FILE"

echo -e "\nBOM verification completed at $(date)" | tee -a "$OUTPUT_FILE"
echo "Results saved to $OUTPUT_FILE"
