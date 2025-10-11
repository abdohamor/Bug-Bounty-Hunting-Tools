#!/bin/bash

install_web_tools() {
    log_message "INFO" "Installing Web Analysis Tools..."
    
    cd "${TOOLS_DIRECTORY}"
    
    log_message "INFO" "Installing waymore..."
    if ! command -v waymore &> /dev/null; then
        git clone https://github.com/xnl-h4ck3r/waymore.git
        cd waymore
        pip3 install .
        cd "${TOOLS_DIRECTORY}"
        if command -v waymore &> /dev/null; then
            echo "waymore" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "waymore installed"
        else
            log_message "WARNING" "waymore installation may have failed"
        fi
    else
        log_message "INFO" "waymore already installed"
    fi
    
    log_message "INFO" "Installing LinkFinder..."
    if [[ ! -d "LinkFinder" ]]; then
        git clone https://github.com/GerbenJavado/LinkFinder.git
        cd LinkFinder
        pip3 install -r requirements.txt
        python setup.py install
        sudo ln -sf "${TOOLS_DIRECTORY}/LinkFinder/linkfinder.py" /usr/local/bin/linkfinder
        sudo chmod +x "${TOOLS_DIRECTORY}/LinkFinder/linkfinder.py"
        cd "${TOOLS_DIRECTORY}"
        if command -v linkfinder &> /dev/null || [[ -x "${TOOLS_DIRECTORY}/LinkFinder/linkfinder.py" ]]; then
            echo "LinkFinder" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "LinkFinder installed"
        else
            log_message "WARNING" "LinkFinder installation may have failed"
        fi
    else
        log_message "INFO" "LinkFinder already exists"
    fi
    
    log_message "INFO" "Installing xnLinkFinder..."
    if ! command -v xnlinkfinder &> /dev/null; then
        git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git
        cd xnLinkFinder
        pip3 install .
        cd "${TOOLS_DIRECTORY}"
        if command -v xnlinkfinder &> /dev/null; then
            echo "xnLinkFinder" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "xnLinkFinder installed"
        else
            log_message "WARNING" "xnLinkFinder installation may have failed"
        fi
    else
        log_message "INFO" "xnLinkFinder already installed"
    fi
    
    log_message "INFO" "Installing ParamSpider..."
    if ! command -v paramspider &> /dev/null; then
        git clone https://github.com/devanshbatham/ParamSpider
        cd ParamSpider
        pip3 install .
        cd "${TOOLS_DIRECTORY}"
        if command -v paramspider &> /dev/null; then
            echo "ParamSpider" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "ParamSpider installed"
        else
            log_message "WARNING" "ParamSpider installation may have failed"
        fi
    else
        log_message "INFO" "ParamSpider already installed"
    fi
    
    log_message "INFO" "Installing SecretFinder..."
    if [[ ! -d "SecretFinder" ]]; then
        git clone https://github.com/m4ll0k/SecretFinder
        cd SecretFinder
        pip3 install -r requirements.txt
        sudo cp SecretFinder.py /usr/local/bin/secretfinder
        sudo chmod +x /usr/local/bin/secretfinder
        cd "${TOOLS_DIRECTORY}"
        if [[ -f "/usr/local/bin/secretfinder" ]]; then
            echo "SecretFinder" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "SecretFinder installed"
        else
            log_message "WARNING" "SecretFinder installation may have failed"
        fi
    else
        log_message "INFO" "SecretFinder already exists"
    fi
    
    log_message "INFO" "Installing FavFreak..."
    if [[ ! -d "FavFreak" ]]; then
        git clone https://github.com/devanshbatham/FavFreak
        cd FavFreak
        pip3 install -r requirements.txt
        sudo cp favfreak.py /usr/local/bin/favfreak
        sudo chmod +x /usr/local/bin/favfreak
        cd "${TOOLS_DIRECTORY}"
        if [[ -f "/usr/local/bin/favfreak" ]]; then
            echo "FavFreak" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "FavFreak installed"
        else
            log_message "WARNING" "FavFreak installation may have failed"
        fi
    else
        log_message "INFO" "FavFreak already exists"
    fi
    
    log_message "INFO" "Installing Crawley..."
    if ! command -v crawley &> /dev/null; then
        mkdir -p crawley && cd crawley
        wget -q https://github.com/s0rg/crawley/releases/download/v1.7.10/crawley_v1.7.10_linux_x86_64.tar.gz
        tar -xzf crawley_v1.7.10_linux_x86_64.tar.gz
        sudo cp crawley /usr/local/bin/
        cd "${TOOLS_DIRECTORY}"
        if command -v crawley &> /dev/null; then
            echo "crawley" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "Crawley installed"
        else
            log_message "WARNING" "Crawley binary move failed"
        fi
    else
        log_message "INFO" "Crawley already installed"
    fi
    
    log_message "INFO" "Installing passurls..."
    if ! command -v passurls &> /dev/null; then
        git clone https://github.com/ahmedhamdy0x/passurls.git
        cd passurls
        pip3 install .
        cd "${TOOLS_DIRECTORY}"
        if command -v passurls &> /dev/null; then
            echo "passurls" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "passurls installed"
        else
            log_message "WARNING" "passurls installation may have failed"
        fi
    else
        log_message "INFO" "passurls already installed"
    fi
    
    log_message "INFO" "Installing urldedupe..."
    if ! command -v urldedupe &> /dev/null; then
        git clone https://github.com/ameenmaali/urldedupe.git
        cd urldedupe && cmake CMakeLists.txt && make && cd ..
        sudo cp urldedupe/urldedupe /usr/local/bin/
        echo "urldedupe" >> "${INSTALL_LOG}"
        log_message "SUCCESS" "urldedupe installed"
    else
        log_message "INFO" "urldedupe already installed"
    fi
    
    log_message "INFO" "Installing VTsubs..."
    if ! command -v vtsubs &> /dev/null; then
        git clone https://github.com/ahmedhamdy0x/VTsubs.git
        cd VTsubs && cargo build --release && cd ..
        sudo cp VTsubs/target/release/VTsubs /usr/local/bin/vtsubs
        sudo chmod +x /usr/local/bin/vtsubs
        echo "VTsubs" >> "${INSTALL_LOG}"
        log_message "SUCCESS" "VTsubs installed"
    else
        log_message "INFO" "VTsubs already installed"
    fi
    
    log_message "INFO" "Installing related-domains..."
    if [[ ! -d "related-domains" ]]; then
        git clone https://github.com/gwen001/related-domains
        cd related-domains
        pip3 install -r requirements.txt
        sudo cp related-domains.py /usr/local/bin/related-domains
        sudo chmod +x /usr/local/bin/related-domains
        cd "${TOOLS_DIRECTORY}"
        if [[ -f "/usr/local/bin/related-domains" ]]; then
            echo "related-domains" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "related-domains installed"
        else
            log_message "WARNING" "related-domains installation may have failed"
        fi
    else
        log_message "INFO" "related-domains already exists"
    fi
    
    log_message "INFO" "Installing GooFuzz..."
    if [[ ! -d "GooFuzz" ]]; then
        git clone https://github.com/m3n0sd0n4ld/GooFuzz.git
        cd GooFuzz
        chmod +x GooFuzz
        sudo ln -sf "${TOOLS_DIRECTORY}/GooFuzz/GooFuzz" /usr/local/bin/goofuzz
        cd "${TOOLS_DIRECTORY}"
        if [[ -x "${TOOLS_DIRECTORY}/GooFuzz/GooFuzz" ]]; then
            echo "GooFuzz" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "GooFuzz installed (run: goofuzz or ${TOOLS_DIRECTORY}/GooFuzz/GooFuzz)"
        else
            log_message "WARNING" "GooFuzz installation may have failed"
        fi
    else
        log_message "INFO" "GooFuzz already exists"
    fi
    
    log_message "SUCCESS" "Web analysis tools installation completed"
}