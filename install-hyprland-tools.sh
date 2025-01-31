#!/bin/bash

# List of packages to install
PACKAGES=(
	hyprland
	wl-clipboard
	wf-recorder
	wofi
	libhyprlang2
	libhyprlang2-debuginfo
	pavucontrol
	hyprland-qtutils
	wlogout
	dunst
	swaybg
	alacritty
	hyprcursor
	noto-fonts
	hyprpicker
	nwg-look
	jq
	gvfs
	mpv
	playerctl
	pamixer
	NetworkManager
	NetworkManager-applet
	neovim
	brightnessctl
	power-profiles-daemon
	waybar
	papirus-icon-theme
	starship
	grim
	slurp
	nautilus
	sddm
)

# Function to install packages
install_packages() {
	echo "Updating package list..."
	sudo zypper refresh

	echo "Installing packages..."
	sudo zypper install -y "${PACKAGES[@]}"

	echo "Installation complete!"
}

# Run installation
install_packages

