#!/bin/bash
set -e

RUN_DIR="$(pwd -P)"

# ensure sudo works
sudo -v

# system update
sudo pacman -Syu --noconfirm

# install packages
sudo pacman -S --needed --noconfirm \
    kitty \
    hyprland \
    hyprpaper \
    waybar \
    dolphin \
    xdg-desktop-portal-hyprland \
    wl-clipboard \
    grim \
    slurp \
    noto-fonts \
    noto-fonts-emoji \
    ttf-jetbrains-mono-nerd \
    pipewire \
    wireplumber \
    base-devel \
    git \
    micro

# make bin dir
mkdir -p "$HOME/bin"
cd "$HOME/bin"

# install brave (AUR)
if [ ! -d brave-bin ]; then
    git clone https://aur.archlinux.org/brave-bin.git
fi

cd brave-bin
makepkg -si --noconfirm

# setup hyprpaper
mkdir -p "$HOME/.config/hyprpaper"

cp -a "$RUN_DIR/bg.png" "$HOME/.config/hyprpaper/bg.png"

HYPR_START="$HOME/.config/hyprpaper/start.sh"
HYPR_CONF="$HOME/.config/hyprpaper/config.conf"

cat <<EOF > "$HYPR_START"
#!/bin/bash
pkill -x hyprpaper || true
sleep 0.2
hyprpaper -c "$HOME/.config/hyprpaper/config.conf"
EOF
chmod +x "$HYPR_START"

MONITOR="$(hyprctl monitors | awk '/Monitor/{print $2; exit}')"
cat <<EOF > "$HYPR_CONF"
wallpaper {
    monitor = name (ex: DP-1)
    path = $HOME/.config/hyprpaper/bg.png
    fit_mode = cover
}

splash = false
EOF