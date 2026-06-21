# /etc/nixos/home.nix
{ config, pkgs, inputs, ... }:

{
  home.username = "arizonapl";
  home.homeDirectory = "/home/arizonapl";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    htop
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  programs.git = {
    enable = true;
    userName = "Szymon Adamczyk";
    userEmail = "szymonadamczyk860@gmail.com";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "zen.desktop" "zen-browser.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" "zen-browser.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" "zen-browser.desktop" ];
      "x-scheme-handler/about" = [ "zen.desktop" "zen-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "zen.desktop" "zen-browser.desktop" ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use NixOS btw";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos-btw";
    };
  };

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      "bar.layouts" = {
        "0" = {
          left = [ "workspaces" ];
          middle = [ "clock" ];
          right = [ "volume" "network" "battery" "power" ];
        };
      };

      "theme.wallpaper.enable" = false;
      "bar.clock.showIcon" = false;
      "bar.clock.showTime" = true;
    };
  };

  xdg.configFile."hypr/hyprland.conf".text = ''
    # --- START ---
    $mainMod = SUPER
    $terminal = kitty
    $fileManager = dolphin
    $menu = hyprlauncher

    binde = $mainMod, K, exec, $terminal
    binde = $mainMod, Q, killactive,
    bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, V, togglefloating
    bind = $mainMod, F, fullscreen
    bind = $mainMod SHIFT, S, exec, flatpak run com.valvesoftware.Steam
    bind = $mainMod SHIFT, D, exec, flatpak run com.discordapp.Discord
    bind = $mainMod, N, exec, $menu
    bind = $mainmod SHIFT, W, exec, pkill hyprpanel && hyprpanel &
    binde = $mainMod, Z, exec, zen-beta

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5

    binde = SUPER SHIFT, right, resizeactive, 30 0
    binde = SUPER SHIFT, left, resizeactive, -30 0
    binde = SUPER SHIFT, up, resizeactive, 0 -30
    binde = SUPER SHIFT, down, resizeactive, 0 30

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    monitor = eDP-1,1920x1080@60,0x0,1.0

    bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0
    bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindl  = , XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindl  = , XF86AudioMicMute,     exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = , XF86MonBrightnessUp,   exec, brightnessctl set 5%+
    bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bindel = , XF86KbdBrightnessUp,   exec, brightnessctl --device='lenovo::kbd_backlight' set 1+
    bindel = , XF86KbdBrightnessDown, exec, brightnessctl --device='lenovo::kbd_backlight' set 1-
    bindl  = , XF86AudioPlay,        exec, playerctl play-pause
    bindl  = , XF86AudioNext,        exec, playerctl next
    bindl  = , XF86AudioPrev,        exec, playerctl previous

    animations {
      enabled = yes
      animation = windows, 1, 4, default, popin 80%
      animation = workspaces, 1, 3, default, slidefade 20%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
    }

    exec-once = hyprpanel
    exec-once = pkill hyprpanel && hyprpanel &
    exec-once = waypaper
    # --- END ---
  '';
}
