!#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Check if user has access to root
sudo -n true
test $? -eq 0 || exit 1 "sudo priviledge needed to run this script"

# Start and enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# System Upgrade to get up to date on stuff
echo doing a system upgrade
yay -Syu

# Chaotic AUR
echo installing chaotic aur
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo  pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
printf "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu
echo Chaotic AUR set up!

# Get base packages
# Not using -Sy to give a chance to audit the packages before install
sudo pacman -S --needed < base_packages.list

# Download the gnome shell extensions to be used
yay -S --needed < shell_extensions.list
