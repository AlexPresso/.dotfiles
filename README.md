## .dotfiles [WIIIIIIIIIIIIIIIIIIIIP]

This is the repository where I store my dotfiles/config files with **an installer**
so I don't have to reinstall and configure everything byhand everytime I switch to another PC.

Feel free to use it, contribute or make suggestions but please note it's not (yet) intended to become a "generic case" installer.

### What's inside ?

- Look and Feel
  - `alacritty`: Fast OpenGL terminal made in Rust (you can also choose another terminal from the installer)
  - `hyprland`: Wayland tiling compositor
  - `swww`: Wallpaper manager
- Audio:
  - `pipewire`
  - `pipewire-pulse`: allows bluetooth audio protocols handling
  - `wireplumber`: automatic switch between audio protocols
- Controllers:
  - `brightnessctl`: control keyboard and monitor brightness
  - `playerctl`: audio player controls
- GUI:
  - `pavucontrol`: control 

### Requirements
- A Keyboard
- Your hands
- Arch (sorry, if you're not using Arch, ["you can go your own way"](https://youtu.be/oiosqtFLBBA?t=31) 😉)

### How to install ?

- clone the repository
- `cd .dotfiles`
- `chmod +x installer.sh`
- `./installer.sh`
- follow the wizzard