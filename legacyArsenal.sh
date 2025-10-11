#!/bin/bash

################################################################################
# Bug Bounty Arsenal - Comprehensive Security Tools Installer
# Developed By: Abdulrahman Muhammad Muhammad (0xlegacy)
# Description: Automated installation of bug bounty hunting tools for Linux
# Requirements: Ubuntu/Debian-based Linux, sudo privileges, internet connection
################################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLS_DIRECTORY="${TOOLS_DIRECTORY:-/opt/tools}"
LOG_FILE="${SCRIPT_DIR}/installation.log"
INSTALL_LOG="${SCRIPT_DIR}/installed_tools.txt"
ERROR_LOG="${SCRIPT_DIR}/errors.log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║         BUG BOUNTY ARSENAL - LEGACY TOOLS INSTALLER          ║"
    echo "║              Comprehensive Security Tools Suite              ║"
    echo "║                  Developed by 0xlegacy                       ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

log_message() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [${level}] ${message}" >> "${LOG_FILE}"
    
    case $level in
        "INFO")
            echo -e "${BLUE}[*]${NC} ${message}"
            ;;
        "SUCCESS")
            echo -e "${GREEN}[✓]${NC} ${message}"
            ;;
        "WARNING")
            echo -e "${YELLOW}[!]${NC} ${message}"
            ;;
        "ERROR")
            echo -e "${RED}[✗]${NC} ${message}"
            echo "[${timestamp}] ${message}" >> "${ERROR_LOG}"
            ;;
    esac
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_message "ERROR" "This script must be run as root or with sudo"
        exit 1
    fi
}

check_prerequisites() {
    log_message "INFO" "Checking prerequisites..."
    
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        log_message "ERROR" "Neither curl nor wget is installed. Please install one of them."
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        log_message "WARNING" "Git is not installed. Installing..."
        apt-get install -y git
    fi
    
    log_message "SUCCESS" "Prerequisites check completed"
}

install_system_dependencies() {
    log_message "INFO" "Installing system dependencies..."
    
    apt-get update -y && apt-get dist-upgrade -y || {
        log_message "ERROR" "Failed to update system packages"
        return 1
    }
    
    local packages=(
        "python3" "python3-pip" "python3.12-venv"
        "cmake" "seclists" "pkg-config" "libssl-dev"
        "chromium" "python2" "python2.7" "gem" "jq"
        "unzip" "make" "gcc" "libpcap-dev" "curl"
        "build-essential" "libcurl4-openssl-dev" "libxml2"
        "libxml2-dev" "libxslt1-dev" "ruby-dev" "ruby"
        "libgmp-dev" "zlib1g-dev" "nmap" "wfuzz"
        "sqlmap" "nikto" "ripgrep" "cargo"
        "software-properties-common" "wget"
    )
    
    for package in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  ${package}"; then
            log_message "INFO" "Installing ${package}..."
            apt-get install -y "${package}" || log_message "WARNING" "Failed to install ${package}"
        fi
    done
    
    gem install wpscan -y || log_message "WARNING" "Failed to install wpscan"
    pip install --break-system-packages pipx || log_message "WARNING" "Failed to install pipx"
    pipx ensurepath
    
    log_message "SUCCESS" "System dependencies installed"
}

install_go() {
    log_message "INFO" "Installing Go programming language..."
    
    if command -v go &> /dev/null; then
        log_message "INFO" "Go is already installed: $(go version)"
        return 0
    fi
    
    local GO_VERSION="1.23.3"
    local GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
    
    cd /tmp
    wget -q "https://go.dev/dl/${GO_TARBALL}" || {
        log_message "ERROR" "Failed to download Go"
        return 1
    }
    
    tar -C /usr/local -xzf "${GO_TARBALL}"
    rm -f "${GO_TARBALL}"
    
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
    fi
    
    if [[ -f ~/.zshrc ]] && ! grep -q "/usr/local/go/bin" ~/.zshrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.zshrc
    fi
    
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    
    log_message "SUCCESS" "Go installed successfully: $(/usr/local/go/bin/go version)"
}

install_rust() {
    log_message "INFO" "Installing Rust programming language..."
    
    if command -v cargo &> /dev/null; then
        log_message "INFO" "Rust is already installed: $(cargo --version)"
        return 0
    fi
    
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || {
        log_message "ERROR" "Failed to install Rust"
        return 1
    }
    
    source "$HOME/.cargo/env"
    rustup default stable
    
    log_message "SUCCESS" "Rust installed successfully"
}

setup_tools_directory() {
    log_message "INFO" "Setting up tools directory: ${TOOLS_DIRECTORY}"
    mkdir -p "${TOOLS_DIRECTORY}"
    cd "${TOOLS_DIRECTORY}"
    log_message "SUCCESS" "Tools directory ready"
}

source_installation_modules() {
    log_message "INFO" "Loading installation modules..."
    
    local modules=(
        "modules/reconnaissance.sh"
        "modules/vulnerability_scanning.sh"
        "modules/exploitation.sh"
        "modules/web_tools.sh"
        "modules/git_tools.sh"
        "modules/go_tools.sh"
    )
    
    for module in "${modules[@]}"; do
        if [[ -f "${SCRIPT_DIR}/${module}" ]]; then
            source "${SCRIPT_DIR}/${module}"
            log_message "SUCCESS" "Loaded module: ${module}"
        else
            log_message "WARNING" "Module not found: ${module}"
        fi
    done
}

show_menu() {
    echo -e "\n${CYAN}Installation Options:${NC}"
    echo "1) Full Installation (All Tools)"
    echo "2) Reconnaissance Tools Only"
    echo "3) Vulnerability Scanning Tools"
    echo "4) Exploitation Tools"
    echo "5) Web Analysis Tools"
    echo "6) Git Reconnaissance Tools"
    echo "7) Go-based Tools"
    echo "8) Prerequisites Only"
    echo "9) View Installed Tools"
    echo "0) Exit"
    echo -n -e "\n${YELLOW}Select option [0-9]: ${NC}"
}

main() {
    show_banner
    check_root
    
    log_message "INFO" "Starting Bug Bounty Arsenal installation..."
    log_message "INFO" "Installation directory: ${TOOLS_DIRECTORY}"
    log_message "INFO" "Log file: ${LOG_FILE}"
    
    check_prerequisites
    
    if [[ "$1" == "--full" ]] || [[ "$1" == "-f" ]]; then
        log_message "INFO" "Running full installation..."
        install_system_dependencies
        install_go
        install_rust
        setup_tools_directory
        source_installation_modules
        
        install_reconnaissance_tools
        install_vulnerability_tools
        install_exploitation_tools
        install_web_tools
        install_git_tools
        install_go_tools
        
        log_message "SUCCESS" "Full installation completed!"
        log_message "INFO" "Check ${LOG_FILE} for details"
        log_message "INFO" "Check ${ERROR_LOG} for any errors"
        exit 0
    fi
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                install_system_dependencies
                install_go
                install_rust
                setup_tools_directory
                source_installation_modules
                install_reconnaissance_tools
                install_vulnerability_tools
                install_exploitation_tools
                install_web_tools
                install_git_tools
                install_go_tools
                log_message "SUCCESS" "Full installation completed!"
                ;;
            2)
                setup_tools_directory
                source_installation_modules
                install_reconnaissance_tools
                ;;
            3)
                setup_tools_directory
                source_installation_modules
                install_vulnerability_tools
                ;;
            4)
                setup_tools_directory
                source_installation_modules
                install_exploitation_tools
                ;;
            5)
                setup_tools_directory
                source_installation_modules
                install_web_tools
                ;;
            6)
                setup_tools_directory
                source_installation_modules
                install_git_tools
                ;;
            7)
                install_go
                source_installation_modules
                install_go_tools
                ;;
            8)
                install_system_dependencies
                install_go
                install_rust
                ;;
            9)
                if [[ -f "${INSTALL_LOG}" ]]; then
                    cat "${INSTALL_LOG}"
                else
                    log_message "WARNING" "No tools installed yet"
                fi
                ;;
            0)
                log_message "INFO" "Exiting..."
                exit 0
                ;;
            *)
                log_message "ERROR" "Invalid option"
                ;;
        esac
    done
}

main "$@"