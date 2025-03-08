#!/bin/bash

echo "🔧 Instalando dependências..."
sudo dnf install -y git \ 
    gtk-murrine-engine \
    sassc \
    libappindicator-gtk3 \
    unzip \
    ostree

# Criar pastas necessárias
mkdir -p ~/.themes ~/.icons ~/Imagens/Wallpapers ~/.fonts

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
cp -r WhiteSur-wallpapers/wallpapers/* ~/Imagens/Wallpapers/
rm -rf WhiteSur-wallpapers

echo "🔤 Baixando e instalando a fonte SF Pro Display..."
wget -O /tmp/SF-Pro.zip "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip"
unzip /tmp/SF-Pro.zip -d /tmp/SF-Pro-Fonts
cp -r /tmp/SF-Pro-Fonts/*/*.ttf ~/.fonts/
rm -rf /tmp/SF-Pro.zip /tmp/SF-Pro-Fonts

# Atualizar cache de fontes
fc-cache -f -v

echo "✅ Instalação concluída!"
