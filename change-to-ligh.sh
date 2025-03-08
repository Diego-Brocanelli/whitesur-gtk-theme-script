#!/bin/bash

config_gtk4() {
  local color="-Light"
  local opacity=""
  local alt=""
  local theme=""
  local scheme=""

  local TARGET_DIR="${HOME}/.config/gtk-4.0"
  local THEME_SRC_DIR="${HOME}/macos-theme/WhiteSur-gtk-theme/src"

  # Install gtk4.0 into config for libadwaita

  mkdir -p                                                                                    "${TARGET_DIR}"

  rm -rf                                                                                      "${TARGET_DIR}/"{gtk.css,gtk-dark.css,gtk-Light.css,gtk-Dark.css,assets,windows-assets}
  sassc ${SASSC_OPT} "${THEME_SRC_DIR}/main/gtk-4.0/gtk-Light.scss"                           "${TARGET_DIR}/gtk-Light.css"
  sassc ${SASSC_OPT} "${THEME_SRC_DIR}/main/gtk-4.0/gtk-Dark.scss"                            "${TARGET_DIR}/gtk-Dark.css"
  ln -sf "${TARGET_DIR}/gtk${color}.css"                                                      "${TARGET_DIR}/gtk.css"
  ln -sf "${TARGET_DIR}/gtk-Dark.css"                                                         "${TARGET_DIR}/gtk-dark.css"
  cp -r "${THEME_SRC_DIR}/assets/gtk/common-assets/assets"                                    "${TARGET_DIR}"
  cp -r "${THEME_SRC_DIR}/assets/gtk/common-assets/sidebar-assets/"*".png"                    "${TARGET_DIR}/assets"
  cp -r "${THEME_SRC_DIR}/assets/gtk/scalable"                                                "${TARGET_DIR}/assets"
  cp -r "${THEME_SRC_DIR}/assets/gtk/windows-assets/titlebutton${alt}${scheme}"               "${TARGET_DIR}/windows-assets"

  echo "Installed ${name}${color}${opacity}${alt}${theme}${scheme} gtk-4.0 theme in '${HOME}/.config/gtk-4.0' for libadwaita!"
}

# Aplicar o tema no GNOME Shell
echo "☀️ Definindo tema, ícones e fonte para Light Mode..."
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Light"
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Light"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
gsettings set org.gnome.desktop.interface font-name "SF Pro Display 11"

gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Light"

config_gtk4

nautilus -q > /dev/null 2>&1
nautilus -w &> /dev/null &

echo "🎨 Tema WhiteSur Light aplicado com sucesso!"
