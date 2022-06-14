{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.mpv;
in {
  options.modules.programs.mpv = { enable = mkEnableOption "mpv"; };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        thumbnail
        sponsorblock
        convert
        cutter
      ];
      config = {
        osc = false;
        fullscreen = true;
        keep-open = true;
        force-seekable = true;
        cursor-autohide = 100;
        osd-bar = false;
        audio-file-auto = "fuzzy";
        volume = 80;
        volume-max = 100;
        demuxer-mkv-subtitle-preroll = true;
        sub-font-size = 52;
        sub-blur = 0.2;
        sub-border-color = "0.0/0.0/0.0/1.0";
        sub-border-size = "3.0";
        sub-color = "1.0/1.0/1.0/1.0";
        sub-margin-x = 100;
        sub-margin-y = 50;
        sub-shadow-color = "0.0/0.0/0.0/0.25";
        sub-shadow-offset = 0;
        alang = "ja,jp,jpn,en,eng,de,deu,ger,pol,pl";
        slang = "en,eng,pol,pl,de,deu,ger";
        screenshot-format = "png";
        screenshot-sw = true;
        screenshot-directory = "~/pics/ss";
        screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
        correct-downscaling = true;
        linear-downscaling = true;
        linear-upscaling = true;
        sigmoid-upscaling = true;
        scale-antiring = 0.7;
        dscale-antiring = 0.7;
        cscale-antiring = 0.7;
        interpolation = true;
        tscale = "sphinx";
        tscale-clamp = 0.0;
        tscale-radius = 1.0;
        tscale-blur = 0.6991556596428412;
        gpu-api = "vulkan";
        target-colorspace-hint = true;
        hwdec = false;
        dither-depth = false;
      };
    };
  };
}
