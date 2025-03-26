#!/bin/bash
sudo apt remove --purge wine-staging wine-staging-amd64 wine-staging-i386:i386 winehq-staging
sudo apt autoclean
sudo apt clean
