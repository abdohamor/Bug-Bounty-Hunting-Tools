#!/bin/bash

################################################################################
# Bug Bounty Arsenal - Uninstaller
# Removes installed tools and cleans up the system
################################################################################

set -e

TOOLS_DIRECTORY="${TOOLS_DIRECTORY:-/opt/tools}"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║       BUG BOUNTY ARSENAL - UNINSTALLER                    ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[✗] This script must be run as root or with sudo${NC}"
    exit 1
fi

echo -e "${YELLOW}[!] WARNING: This will remove all installed bug bounty tools${NC}"
echo -n "Are you sure you want to continue? (yes/no): "
read -r confirmation

if [[ "$confirmation" != "yes" ]]; then
    echo -e "${GREEN}[✓] Uninstallation cancelled${NC}"
    exit 0
fi

echo -e "${CYAN}[*] Starting uninstallation...${NC}"

echo -e "${CYAN}[*] Removing tools directory: ${TOOLS_DIRECTORY}${NC}"
rm -rf "${TOOLS_DIRECTORY}"

echo -e "${CYAN}[*] Removing binaries from /usr/local/bin${NC}"
BINARIES=(
    "subfinder" "assetfinder" "httpx" "nuclei" "katana"
    "naabu" "dnsx" "puredns" "alterx" "shuffledns"
    "gobuster" "ffuf" "dalfox" "waybackurls" "gau"
    "hakrawler" "gospider" "httprobe" "amass" "findomain"
    "massdns" "masscan" "dirsearch" "arjun" "kr"
    "dontgo403" "subextreme" "crawley" "urldedupe" "vtsubs"
    "sublist3r" "waymore" "paramspider" "subhunter"
)

for binary in "${BINARIES[@]}"; do
    if [[ -f "/usr/local/bin/${binary}" ]]; then
        rm -f "/usr/local/bin/${binary}"
        echo -e "${GREEN}[✓] Removed ${binary}${NC}"
    fi
done

echo -e "${CYAN}[*] Removing Go tools from ~/go/bin${NC}"
rm -rf ~/go/bin/*

echo -e "${CYAN}[*] Cleaning up log files${NC}"
rm -f installation.log errors.log installed_tools.txt

echo -e "${GREEN}[✓] Uninstallation completed${NC}"
echo -e "${YELLOW}[!] Note: Go, Rust, and system packages were not removed${NC}"
echo -e "${YELLOW}[!] To remove Go: sudo rm -rf /usr/local/go${NC}"
echo -e "${YELLOW}[!] To remove Rust: rustup self uninstall${NC}"