{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  prg = osConfig.modules.programs;

  dev = osConfig.modules.device;
  sys = osConfig.modules.system;
  acceptedTypes = ["laptop" "desktop" "hybrid" "lite"];
in {
  config = mkIf ((prg.gui.enable && sys.video.enable) && (builtins.elem dev.type acceptedTypes)) {
    home.packages = with pkgs; [
      # zoom-us # may we never return to online education
      nextcloud-client
      easyeffects
      librewolf
      cinnamon.nemo
      schildichat-desktop
      qbittorrent
      hexchat
      netflix
      bitwarden
      (symlinkJoin {
        # wrap obsidian with pandoc for the pandoc plugin dependency
        name = "Obsidian";
        paths = with pkgs; [obsidian pandoc];
      })

      # plasma packages
      plasma5Packages.dolphin
      plasma5Packages.dolphin-plugins
      plasma5Packages.kio
      plasma5Packages.kio-extras
      plasma5Packages.kimageformats
      plasma5Packages.kdegraphics-thumbnailers
      plasma5Packages.okular

      # gnome packages
      gnome.gnome-tweaks
      gnome.gnome-calendar
      komikku

      # override gnome-control-center to trick it into thinking we're running gnome
      # <https://github.com/NixOS/nixpkgs/issues/230493>
      # <https://gitlab.gnome.org/GNOME/gnome-control-center/-/merge_requests/736>
      # get overriden idiot
      (gnome.gnome-control-center.overrideAttrs
        (old: {
          # gnome-control-center does not start without XDG_CURRENT_DESKTOP=gnome
          preFixup =
            ''
              gappsWrapperArgs+=(
                --set XDG_CURRENT_DESKTOP "gnome"
              );
            ''
            + old.preFixup;
        }))
    ];
  };
}
