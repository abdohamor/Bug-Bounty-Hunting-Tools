#!/bin/bash

install_git_tools() {
    log_message "INFO" "Installing Git Reconnaissance Tools..."
    
    cd "${TOOLS_DIRECTORY}"
    
    log_message "INFO" "Installing GitDorker..."
    if [[ ! -d "GitDorker" ]]; then
        git clone https://github.com/obheda12/GitDorker.git
        cd GitDorker
        pip3 install -r requirements.txt
        sudo ln -sf "${TOOLS_DIRECTORY}/GitDorker/GitDorker.py" /usr/local/bin/gitdorker
        sudo chmod +x "${TOOLS_DIRECTORY}/GitDorker/GitDorker.py"
        cd "${TOOLS_DIRECTORY}"
        if command -v gitdorker &> /dev/null || [[ -x "${TOOLS_DIRECTORY}/GitDorker/GitDorker.py" ]]; then
            echo "GitDorker" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "GitDorker installed"
        else
            log_message "WARNING" "GitDorker installation may have failed"
        fi
    else
        log_message "INFO" "GitDorker already exists"
    fi
    
    log_message "INFO" "Installing gitGraber..."
    if [[ ! -d "gitGraber" ]]; then
        git clone https://github.com/hisxo/gitGraber.git
        cd gitGraber
        pip3 install -r requirements.txt
        sudo ln -sf "${TOOLS_DIRECTORY}/gitGraber/gitGraber.py" /usr/local/bin/gitgraber
        sudo chmod +x "${TOOLS_DIRECTORY}/gitGraber/gitGraber.py"
        cd "${TOOLS_DIRECTORY}"
        if command -v gitgraber &> /dev/null || [[ -x "${TOOLS_DIRECTORY}/gitGraber/gitGraber.py" ]]; then
            echo "gitGraber" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "gitGraber installed"
        else
            log_message "WARNING" "gitGraber installation may have failed"
        fi
    else
        log_message "INFO" "gitGraber already exists"
    fi
    
    log_message "INFO" "Installing GitTools..."
    if ! command -v gitfinder &> /dev/null; then
        git clone https://github.com/internetwache/GitTools.git
        if [[ -d "GitTools" ]]; then
            sudo chmod +x "${TOOLS_DIRECTORY}/GitTools/Finder/gitfinder.py"
            sudo chmod +x "${TOOLS_DIRECTORY}/GitTools/Dumper/gitdumper.sh"
            sudo chmod +x "${TOOLS_DIRECTORY}/GitTools/Extractor/extractor.sh"
            sudo ln -sf "${TOOLS_DIRECTORY}/GitTools/Finder/gitfinder.py" /usr/local/bin/gitfinder
            sudo ln -sf "${TOOLS_DIRECTORY}/GitTools/Dumper/gitdumper.sh" /usr/local/bin/gitdumper
            sudo ln -sf "${TOOLS_DIRECTORY}/GitTools/Extractor/extractor.sh" /usr/local/bin/gitextractor
            if command -v gitfinder &> /dev/null && \
               command -v gitdumper &> /dev/null && \
               command -v gitextractor &> /dev/null; then
                echo "GitTools" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "GitTools installed (gitfinder, gitdumper, gitextractor)"
            else
                log_message "WARNING" "GitTools commands not accessible via PATH"
            fi
        else
            log_message "WARNING" "GitTools clone failed"
        fi
    else
        log_message "INFO" "GitTools already installed"
    fi
    
    log_message "INFO" "Installing DumpsterDiver..."
    if [[ ! -d "DumpsterDiver" ]]; then
        git clone https://github.com/securing/DumpsterDiver.git
        cd DumpsterDiver
        pip3 install -r requirements.txt
        sudo ln -sf "${TOOLS_DIRECTORY}/DumpsterDiver/DumpsterDiver.py" /usr/local/bin/dumpsterdiver
        sudo chmod +x "${TOOLS_DIRECTORY}/DumpsterDiver/DumpsterDiver.py"
        cd "${TOOLS_DIRECTORY}"
        if command -v dumpsterdiver &> /dev/null || [[ -x "${TOOLS_DIRECTORY}/DumpsterDiver/DumpsterDiver.py" ]]; then
            echo "DumpsterDiver" >> "${INSTALL_LOG}"
            log_message "SUCCESS" "DumpsterDiver installed"
        else
            log_message "WARNING" "DumpsterDiver installation may have failed"
        fi
    else
        log_message "INFO" "DumpsterDiver already exists"
    fi
    
    log_message "INFO" "Installing BadGPT..."
    if [[ ! -d "BadGPT" ]]; then
        git clone https://github.com/NeM0x00/BadGPT.git
        cd BadGPT
        if [[ -f "badgpt.py" ]]; then
            pip3 install -r requirements.txt
            sudo ln -sf "${TOOLS_DIRECTORY}/BadGPT/badgpt.py" /usr/local/bin/badgpt
            sudo chmod +x "${TOOLS_DIRECTORY}/BadGPT/badgpt.py"
            cd "${TOOLS_DIRECTORY}"
            if command -v badgpt &> /dev/null || [[ -x "${TOOLS_DIRECTORY}/BadGPT/badgpt.py" ]]; then
                echo "BadGPT" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "BadGPT installed (run: badgpt)"
            else
                log_message "WARNING" "BadGPT installation verification failed"
            fi
        else
            cd "${TOOLS_DIRECTORY}"
            log_message "WARNING" "BadGPT main script not found"
        fi
    else
        log_message "INFO" "BadGPT already exists"
    fi
    
    log_message "INFO" "Installing earlybird..."
    if ! command -v earlybird &> /dev/null; then
        git clone https://github.com/americanexpress/earlybird.git
        cd earlybird
        if ./build.sh && ./install.sh; then
            cd "${TOOLS_DIRECTORY}"
            if command -v earlybird &> /dev/null; then
                echo "earlybird" >> "${INSTALL_LOG}"
                log_message "SUCCESS" "earlybird installed"
            else
                log_message "WARNING" "earlybird build succeeded but command not found"
            fi
        else
            cd "${TOOLS_DIRECTORY}"
            log_message "WARNING" "earlybird build/install failed"
        fi
    else
        log_message "INFO" "earlybird already installed"
    fi
    
    log_message "SUCCESS" "Git reconnaissance tools installation completed"
}