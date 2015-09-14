#!/bin/bash
# Download the installer generator, and execute it
git clone https://github.com/invernizzi/quick-deploy.git quick-deploy
quick-deploy/create_installer.sh src/ install.sh
quick-deploy/create_installer.sh src-desktop/ install_desktop.sh
rm -Rf quick-deploy


