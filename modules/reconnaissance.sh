#!/bin/bash

install_reconnaissance_tools() {
    log_message "INFO" "Installing Reconnaissance Tools..."
    
    cd "${TOOLS_DIRECTORY}"
    
    log_message "INFO" "Installing Sublist3r..."
    if ! command -v sublist3r &> /dev/null; then
        git clone https://github.com/aboul3la/Sublist3r.git
        cd Sublist3r
        pip3 install -r requirements.txt
        sudo cp sublist3r.py /usr/local/bin/sublist3r
        sudo chmod +x /usr/local/bin/sublist3r
        cd "${TOOLS_DIRECTORY}"
        if command -v sublist3r &> /dev/null || [[ -f "/usr/local/bin/sublist3r" ]]; then
            echo "sublist3r" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "Sublist3r installed"
        else
            log_message "WARNING" "Sublist3r installation may have failed"
        fi
    else
        log_message "INFO" "Sublist3r already installed"
    fi
    
    log_message "INFO" "Installing Amass..."
    if ! command -v amass &> /dev/null; then
        AMASSVER=$(curl -s https://api.github.com/repos/OWASP/Amass/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
        wget -q "https://github.com/OWASP/Amass/releases/download/${AMASSVER}/amass_linux_amd64.zip"
        unzip -q amass_linux_amd64.zip
        sudo mv amass_linux_amd64/amass /usr/local/bin/
        rm -rf amass_linux_amd64 amass_linux_amd64.zip
        if command -v amass &> /dev/null; then
            echo "amass" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "Amass installed"
        else
            log_message "WARNING" "Amass binary move failed"
        fi
    else
        log_message "INFO" "Amass already installed"
    fi
    
    log_message "INFO" "Installing Findomain..."
    if ! command -v findomain &> /dev/null; then
        wget -q https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux.zip
        unzip -q findomain-linux.zip
        chmod +x findomain
        sudo mv findomain /usr/local/bin/
        rm -f findomain-linux.zip
        if command -v findomain &> /dev/null; then
            echo "findomain" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "Findomain installed"
        else
            log_message "WARNING" "Findomain binary move failed"
        fi
    else
        log_message "INFO" "Findomain already installed"
    fi
    
    log_message "INFO" "Installing MassDNS..."
    if ! command -v massdns &> /dev/null; then
        git clone https://github.com/blechschmidt/massdns.git
        cd massdns
        if make; then
            cd ..
            if [[ -f "massdns/bin/massdns" ]]; then
                sudo cp massdns/bin/massdns /usr/local/bin/
                if command -v massdns &> /dev/null; then
                    echo "massdns" >> "${INSTALL_LOG}"
                    log_message "SUCCESS" "MassDNS installed"
                else
                    log_message "WARNING" "MassDNS binary copy failed"
                fi
            else
                log_message "WARNING" "MassDNS build did not produce binary"
            fi
        else
            cd "${TOOLS_DIRECTORY}"
            log_message "WARNING" "MassDNS build failed"
        fi
    else
        log_message "INFO" "MassDNS already installed"
    fi
    
    log_message "INFO" "Installing Masscan..."
    if ! command -v masscan &> /dev/null; then
        git clone https://github.com/robertdavidgraham/masscan
        cd masscan
        if make && sudo make install; then
            cd "${TOOLS_DIRECTORY}"
            if command -v masscan &> /dev/null; then
                echo "masscan" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "Masscan installed"
            else
                log_message "WARNING" "Masscan installation succeeded but command not found"
            fi
        else
            cd "${TOOLS_DIRECTORY}"
            log_message "WARNING" "Masscan build or installation failed"
        fi
    else
        log_message "INFO" "Masscan already installed"
    fi
    
    log_message "INFO" "Installing resolveDomains..."
    if ! command -v resolveDomains &> /dev/null; then
        git clone https://github.com/Josue87/resolveDomains.git
        cd resolveDomains && go build && cd ..
        if [[ -f "resolveDomains/resolveDomains" ]]; then
            sudo cp resolveDomains/resolveDomains /usr/local/bin/
            if command -v resolveDomains &> /dev/null; then
                echo "resolveDomains" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "resolveDomains installed"
            else
                log_message "WARNING" "resolveDomains binary copy failed"
            fi
        else
            log_message "WARNING" "resolveDomains build failed"
        fi
    else
        log_message "INFO" "resolveDomains already installed"
    fi
    
    log_message "INFO" "Installing Subextreme..."
    if ! command -v subextreme &> /dev/null; then
        git clone https://github.com/ahmedhamdy0x/subextreme.git
        cd subextreme
        cargo build --release
        sudo cp target/release/subextreme /usr/local/bin/
        cd "${TOOLS_DIRECTORY}"
        if command -v subextreme &> /dev/null; then
            echo "subextreme" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "Subextreme installed"
        else
            log_message "WARNING" "Subextreme installation may have failed"
        fi
    else
        log_message "INFO" "Subextreme already installed"
    fi
    
    log_message "INFO" "Installing Subhunter..."
    if ! command -v subhunter &> /dev/null; then
        git clone https://github.com/Nemesis0U/Subhunter.git
        cd Subhunter && go build subhunter.go && cd ..
        if [[ -f "Subhunter/subhunter" ]]; then
            sudo cp Subhunter/subhunter /usr/local/bin/
            if command -v subhunter &> /dev/null; then
                echo "subhunter" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "Subhunter installed"
            else
                log_message "WARNING" "Subhunter binary copy failed"
            fi
        else
            log_message "WARNING" "Subhunter build failed"
        fi
    else
        log_message "INFO" "Subhunter already installed"
    fi
    
    log_message "SUCCESS" "Reconnaissance tools installation completed"
}