#!/bin/bash

# List of packages to install
PACKAGES=(
	hyprland
	hyprlock
	wl-clipboard
	wf-recorder
	rofi-wayland
	rofi-network-manager
	libhyprlang2
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
	xdg-desktop-portal-wlr
	xdg-desktop-portal-hyprland
	xdg-desktop-portal
)

# Function to install packages
install_packages() {
	echo "Installing packages..."
	paru -Syu -y "${PACKAGES[@]}"

	echo "Installation complete!"
}

# Run installation
install_packages

