#!/usr/bin/env bash
set -e

echo "> Installing Inv's Hyprland Template..."

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
  hyprland \
  xdg-desktop-portal-hyprland \
  waybar \
  hyprpaper \
  dolphin \
  kitty \
  wl-clipboard \
  ttf-jetbrains-mono-nerd \
  ttf-fira-code-nerd \
  noto-fonts \
  noto-fonts-emoji \
  pipewire \
  wireplumber \
  polkit-kde-agent \
  grim slurp

echo "> 'Hyprland' to start."
