#!/bin/bash

# Atualizando o sistema
echo "🛠️ Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

# Instalando o GNOME Tweaks
echo "📦 Instalando o GNOME Tweaks..."
sudo apt install gnome-tweaks -y

# Instalando o Extension Manager (por Matthew Jakenman)
echo "📦 Instalando Extension Manager..."
sudo apt install gnome-shell-extension-manager -y

# Instalando as extensões
echo "📦 Instalando extensões GNOME..."
gnome-extensions install --no-local https://extensions.gnome.org/extension/4103/blur-my-shell/
gnome-extensions install --no-local https://extensions.gnome.org/extension/3772/compix-alike-magic-lamp-effect/
gnome-extensions install --no-local https://extensions.gnome.org/extension/1039/night-theme-switcher/
gnome-extensions install --no-local https://extensions.gnome.org/extension/19/user-themes/

# Ativando as extensões
echo "⚙️ Ativando as extensões..."

# Blur my Shell
gnome-extensions enable blur-my-shell@aunetx.gmail.com

# Compix Alike Magic Lamp Effect
gnome-extensions enable compix-alike-magic-lamp-effect@hanselmeister.com

# Compiz Windows Effect
gnome-extensions enable compiz-windows-effect@hermes83.github.com

# Night Theme Switcher
gnome-extensions enable night-theme-switcher@gnome-shell-extensions.gcampax.github.com

# User Themes
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

# Search Light
gnome-extensions enable search-light@icedman.github.com

# GNOME 4x UI Improvements
gnome-extensions enable gnome-4x-ui-improvements@mmprophet.gmail.com

# Confirmação
echo "✅ Extensões instaladas e ativadas com sucesso!"

echo "🔧 Instalando dependências..."
sudo dnf install -y git \ 
    gtk-murrine-engine \
    sassc \
    libappindicator-gtk3 \
    unzip \
    ostree

# Criar pastas necessárias
mkdir -p ~/.themes ~/.icons ~/images/wallpapers ~/.fonts

echo "🎨 Baixando e instalando o WhiteSur Theme..."
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh --dest $HOME/.themes \
    --libadwaita \
    --monterey \
    --nautilus glassy \
    --fixed \
    --round 
sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo ./tweaks.sh --color light --flatpak -g

# sudo rm -Rf WhiteSur-gtk-theme

cd ..

echo "🎨 Baixando e instalando os ícones WhiteSur..."
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh --dest $HOME/.icons

sudo rm -rf WhiteSur-icon-theme

cd ..

echo "🖼️ Baixando e instalando os wallpapers do WhiteSur..."
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-wallpapers.git
cp -r WhiteSur-wallpapers/1080p/*.jpg ~/images/wallpapers/
cp -r WhiteSur-wallpapers/2k/*.jpg ~/images/wallpapers/
cp -r WhiteSur-wallpapers/4k/*.jpg ~/images/wallpapers/
rm -rf WhiteSur-wallpapers

echo "🔤 Baixando e instalando a fonte SF Pro Display..."
wget -O /tmp/SF-Pro.zip "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip"
unzip /tmp/SF-Pro.zip -d /tmp/SF-Pro-Fonts
cp -r /tmp/SF-Pro-Fonts/*/*.ttf ~/.fonts/
rm -rf /tmp/SF-Pro.zip /tmp/SF-Pro-Fonts

# Atualizar cache de fontes
fc-cache -f -v

echo "✅ Instalação concluída!"
