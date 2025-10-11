# Bug Bounty Arsenal - Legacy Tools Installer

<div align="center">

[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/0xlegacy52/Bug-Bounty-Hunting-Tools)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)](https://www.linux.org/)

**A comprehensive automated installer for bug bounty hunting tools on Linux systems**

Developed by: **Abdulrahman Muhammad Muhammad (0xlegacy)**

</div>

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Tool Categories](#tool-categories)
- [Installed Tools](#installed-tools)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## 🎯 Overview

Bug Bounty Arsenal is an automated installation script designed for security researchers and bug bounty hunters. It streamlines the process of setting up a complete security testing environment by installing and configuring 100+ essential tools in one go.

### What's New in v2.0

- ✅ Modular architecture with organized tool categories
- ✅ Comprehensive error handling and logging
- ✅ Interactive menu system for selective installation
- ✅ Progress tracking and installation verification
- ✅ Improved dependency management
- ✅ Detailed installation logs and error reporting

---

## ✨ Features

- **Automated Installation**: Install 100+ security tools with a single command
- **Modular Design**: Install specific tool categories based on your needs
- **Smart Dependency Management**: Automatically handles prerequisites
- **Progress Tracking**: Real-time installation progress with colored output
- **Error Logging**: Comprehensive logging for troubleshooting
- **Interactive Menu**: Choose what to install via user-friendly interface
- **Version Control**: Installs latest versions of all tools

---

## 📦 Requirements

### System Requirements

- **Operating System**: Ubuntu 20.04+ / Debian 10+ / Kali Linux
- **Privileges**: Root or sudo access
- **Storage**: Minimum 10GB free space
- **RAM**: 4GB+ recommended
- **Internet**: Stable connection required

### Pre-installed Software

The script will automatically install these if missing:
- Python 3.8+
- Go 1.23.3
- Rust (latest stable)
- Git
- Build tools (gcc, make, cmake)

---

## 🚀 Installation

### Quick Start

```bash
# Clone the repository
git clone https://github.com/0xlegacy52/Bug-Bounty-Hunting-Tools.git

# Navigate to directory
cd Bug-Bounty-Hunting-Tools

# Make the script executable
chmod +x legacyArsenal.sh

# Run with sudo
sudo bash legacyArsenal.sh
```

### Full Installation (Non-Interactive)

```bash
sudo bash legacyArsenal.sh --full
```

---

## 💻 Usage

### Interactive Mode

Run the script without arguments for the interactive menu:

```bash
sudo bash legacyArsenal.sh
```

You'll see options:
1. Full Installation (All Tools)
2. Reconnaissance Tools Only
3. Vulnerability Scanning Tools
4. Exploitation Tools
5. Web Analysis Tools
6. Git Reconnaissance Tools
7. Go-based Tools
8. Prerequisites Only
9. View Installed Tools
0. Exit

### Command-Line Arguments

```bash
# Full installation
sudo bash legacyArsenal.sh --full

# Full installation (short form)
sudo bash legacyArsenal.sh -f
```

### View Logs

```bash
# Installation log
cat installation.log

# Error log
cat errors.log

# Installed tools list
cat installed_tools.txt
```

---

## 🔧 Tool Categories

### 1. Reconnaissance Tools

Subdomain enumeration, DNS reconnaissance, and asset discovery:

- **Sublist3r** - Subdomain enumeration
- **Amass** - OWASP network mapping
- **Findomain** - Fast subdomain finder
- **MassDNS** - High-performance DNS resolver
- **Masscan** - Fast port scanner
- **resolveDomains** - Domain resolver
- **Subextreme** - Subdomain discovery
- **Subhunter** - Subdomain finder

### 2. Vulnerability Scanning Tools

Directory brute-forcing and vulnerability detection:

- **dirsearch** - Web path scanner
- **Arjun** - HTTP parameter discovery
- **Kiterunner** - API endpoint finder
- **dontgo403** - 403 bypass tool
- **NoSQLMap** - NoSQL injection scanner

### 3. Exploitation Tools

XSS, SSRF, CORS, and other vulnerability exploitation:

- **XSStrike** - XSS detection suite
- **Corsy** - CORS misconfiguration scanner
- **SSRFmap** - SSRF exploitation tool
- **Gopherus** - SSRF payload generator
- **autossrf** - SSRF automation
- **tplmap** - Template injection scanner
- **LFISuite** - LFI exploitation
- **ppmap** - Prototype pollution scanner

### 4. Web Analysis Tools

Web crawling, parameter discovery, and secret finding:

- **waymore** - Wayback machine data fetcher
- **LinkFinder** - JavaScript endpoint discovery
- **xnLinkFinder** - Enhanced link finder
- **ParamSpider** - Parameter miner
- **SecretFinder** - Secret key finder
- **FavFreak** - Favicon analysis
- **Crawley** - Web crawler
- **passurls** - Passive URL collector
- **urldedupe** - URL deduplication
- **VTsubs** - VirusTotal subdomain finder
- **related-domains** - Related domain finder
- **GooFuzz** - Google dorking tool

### 5. Git Reconnaissance Tools

GitHub/GitLab reconnaissance and secret finding:

- **GitDorker** - GitHub dorking
- **gitGraber** - GitHub monitoring
- **GitTools** - Git repository exploitation
- **DumpsterDiver** - Secret analysis
- **BadGPT** - GPT-based recon
- **earlybird** - Secret detection

### 6. Go-based Tools (50+ tools)

High-performance security tools written in Go:

#### Subdomain Enumeration
- subfinder, assetfinder, github-subdomains, gitlab-subdomains
- shuffledns, puredns, alterx, gotator

#### Network Scanning
- httpx, httprobe, naabu, masscan

#### Web Crawling
- katana, hakrawler, gospider, waybackurls, gau

#### Vulnerability Scanning
- nuclei, dalfox, kxss, crlfuzz
- ffuf, gobuster, ffuf, fuzzuli

#### Utilities
- dnsx, mapcidr, anew, unfurl, qsreplace
- notify, interactsh-client, pdtm

---

## 📊 Installed Tools

After installation, tools are located in:

- **System binaries**: `/usr/local/bin/`
- **Source code**: `/opt/tools/`
- **Go tools**: `$HOME/go/bin/`
- **Python virtual envs**: `/opt/tools/*-env/`

### Verify Installation

```bash
# Check specific tool
which subfinder
nuclei -version

# View all installed tools
cat installed_tools.txt
```

---

## ⚙️ Configuration

### Custom Installation Directory

Set the `TOOLS_DIRECTORY` environment variable:

```bash
export TOOLS_DIRECTORY="/custom/path"
sudo -E bash legacyArsenal.sh
```

### Environment Setup

Add Go and Rust to your PATH (done automatically):

```bash
# Added to ~/.bashrc and ~/.zshrc
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
```

Reload your shell:

```bash
source ~/.bashrc  # or ~/.zshrc
```

---

## 🐛 Troubleshooting

### Common Issues

**1. Permission Denied**
```bash
# Ensure you're running with sudo
sudo bash legacyArsenal.sh
```

**2. Network Errors**
```bash
# Check internet connection
ping -c 3 google.com

# Check DNS resolution
nslookup github.com
```

**3. Dependency Errors**
```bash
# Run prerequisites installation first
sudo bash legacyArsenal.sh
# Select option 8 (Prerequisites Only)
```

**4. Go Command Not Found**
```bash
# Reload PATH
source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```

**5. Python Virtual Environment Issues**
```bash
# Install python3-venv
sudo apt-get install python3.12-venv
```

### Check Logs

```bash
# View installation log
tail -f installation.log

# View errors only
cat errors.log

# Search for specific errors
grep -i "error" installation.log
```

---

## 📝 Installation Directory Structure

```
/opt/tools/
├── Sublist3r/
├── Arjun/
├── dirsearch/
├── LinkFinder/
├── XSStrike/
├── GitDorker/
├── Gf-Patterns/
├── OneListForAll/
├── jaeles-signatures/
├── *-env/                 # Python virtual environments
└── ... (100+ tools)

/usr/local/bin/
├── subfinder
├── nuclei
├── httpx
├── katana
└── ... (compiled binaries)

~/go/bin/
└── ... (Go-based tools)
```

---

## 🔐 Security Notes

- Always use these tools **ethically** and with **proper authorization**
- Comply with bug bounty program rules and scope
- Respect rate limits and terms of service
- Never test on systems without permission
- Keep tools updated regularly

---

## 🤝 Contributing

Contributions are welcome! To add new tools:

1. Fork the repository
2. Add tool installation to appropriate module in `modules/`
3. Update README with tool description
4. Test on fresh Ubuntu/Debian system
5. Submit pull request

---

## 🙏 Credits

**Developed by**: Abdulrahman Muhammad Muhammad (0xlegacy)

**Special thanks to all the tool developers:**
- ProjectDiscovery Team
- OWASP Amass Team
- Tom Hudson (tomnomnom)
- And all open-source security researchers

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/0xlegacy52/Bug-Bounty-Hunting-Tools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/0xlegacy52/Bug-Bounty-Hunting-Tools/discussions)

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

Made with ❤️ by the security community

</div>