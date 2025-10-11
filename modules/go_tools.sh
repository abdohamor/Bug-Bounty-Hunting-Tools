#!/bin/bash

install_go_tools() {
    log_message "INFO" "Installing Go-based Tools..."
    
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    
    local go_tools=(
        "github.com/projectdiscovery/pdtm/cmd/pdtm@latest"
        "github.com/projectdiscovery/httpx/cmd/httpx@latest"
        "github.com/hahwul/dalfox/v2@latest"
        "github.com/projectdiscovery/notify/cmd/notify@latest"
        "github.com/edoardottt/csprecon/cmd/csprecon@latest"
        "github.com/lc/gau/v2/cmd/gau@latest"
        "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
        "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
        "github.com/tomnomnom/httprobe@latest"
        "github.com/utkusen/socialhunter@latest"
        "github.com/003random/getJS/v2@latest"
        "github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
        "github.com/j3ssie/osmedeus@latest"
        "github.com/tomnomnom/assetfinder@latest"
        "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
        "github.com/projectdiscovery/katana/cmd/katana@latest"
        "github.com/Josue87/gotator@latest"
        "github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest"
        "github.com/hakluke/hakrawler@latest"
        "github.com/0xsha/GoLinkFinder@latest"
        "github.com/projectdiscovery/uncover/cmd/uncover@latest"
        "github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest"
        "github.com/tomnomnom/meg@latest"
        "github.com/tomnomnom/waybackurls@latest"
        "github.com/jaeles-project/gospider@latest"
        "github.com/PentestPad/subzy@latest"
        "github.com/channyein1337/jsleak@latest"
        "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
        "github.com/OJ/gobuster/v3@latest"
        "github.com/edoardottt/scilla/cmd/scilla@latest"
        "github.com/projectdiscovery/alterx/cmd/alterx@latest"
        "github.com/tomnomnom/anew@latest"
        "github.com/projectdiscovery/asnmap/cmd/asnmap@latest"
        "github.com/d3mondev/puredns/v2@latest"
        "github.com/tomnomnom/hacks/anti-burl@latest"
        "github.com/cgboal/sonarsearch/cmd/crobat@latest"
        "github.com/Ractiurd/jscracker@latest"
        "github.com/s0md3v/smap/cmd/smap@latest"
        "github.com/lc/subjs@latest"
        "github.com/musana/fuzzuli@latest"
        "github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
        "github.com/tomnomnom/gron@latest"
        "github.com/Josue87/resolveDomains@latest"
        "github.com/haccer/subjack@latest"
        "github.com/gwen001/gitlab-subdomains@latest"
        "github.com/gwen001/github-subdomains@latest"
        "github.com/ffuf/ffuf@latest"
        "github.com/tomnomnom/hacks/kxss@latest"
        "github.com/tomnomnom/unfurl@latest"
        "github.com/tomnomnom/qsreplace@latest"
        "github.com/dhn/spk@latest"
        "github.com/vodafon/waybackrobots@latest"
        "github.com/shenwei356/rush@latest"
        "github.com/mhmdiaa/second-order@latest"
    )
    
    for tool in "${go_tools[@]}"; do
        tool_name=$(echo "$tool" | awk -F'/' '{print $NF}' | cut -d'@' -f1)
        log_message "INFO" "Installing ${tool_name}..."
        
        if [[ "$tool" == *"GO111MODULE=on"* ]]; then
            GO111MODULE=on go install -v "$tool" 2>/dev/null || log_message "WARNING" "Failed to install ${tool_name}"
        else
            go install -v "$tool" 2>/dev/null || log_message "WARNING" "Failed to install ${tool_name}"
        fi
        
        if command -v "${tool_name}" &> /dev/null; then
            echo "${tool_name}" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "${tool_name} installed"
        fi
    done
    
    if command -v pdtm &> /dev/null; then
        log_message "INFO" "Running pdtm -ia to install all ProjectDiscovery tools..."
        pdtm -ia || log_message "WARNING" "pdtm -ia failed"
    fi
    
    if command -v nuclei &> /dev/null; then
        log_message "INFO" "Updating Nuclei templates..."
        nuclei -update-templates || log_message "WARNING" "Failed to update Nuclei templates"
    fi
    
    log_message "INFO" "Installing additional tools and patterns..."
    cd "${TOOLS_DIRECTORY}"
    
    if [[ ! -d "Gf-Patterns" ]]; then
        git clone https://github.com/1ndianl33t/Gf-Patterns
        echo "Gf-Patterns" >> "${INSTALL_LOG}"
        log_message "SUCCESS" "Gf-Patterns installed"
    fi
    
    if [[ ! -d "OneListForAll" ]]; then
        git clone https://github.com/six2dez/OneListForAll.git
        echo "OneListForAll" >> "${INSTALL_LOG}"
        log_message "SUCCESS" "OneListForAll installed"
    fi
    
    if [[ ! -d "jaeles-signatures" ]]; then
        git clone https://github.com/jaeles-project/jaeles-signatures.git
        echo "jaeles-signatures" >> "${INSTALL_LOG}"
        log_message "SUCCESS" "jaeles-signatures installed"
    fi
    
    if ! command -v interlace &> /dev/null; then
        git clone https://github.com/codingo/Interlace.git
        cd Interlace
        if python3 setup.py install; then
            cd "${TOOLS_DIRECTORY}"
            if command -v interlace &> /dev/null; then
                echo "Interlace" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "Interlace installed"
            else
                log_message "WARNING" "Interlace installation succeeded but command not found"
            fi
        else
            cd "${TOOLS_DIRECTORY}"
            log_message "WARNING" "Interlace installation failed"
        fi
    else
        log_message "INFO" "Interlace already installed"
    fi
    
    log_message "SUCCESS" "Go-based tools installation completed"
}