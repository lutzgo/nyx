{ pkgs, config, theme, ...}:

{
  programs.alacritty = {
    enable = true;
    settings = with theme.colors; {
      window.dimensions ={
        columns = 100;
        lines = 85;
      };
      padding = {
        x = 26;
        y = 26;
      };
      scrolling = {
        history = 38;
        multiplier = 3;
      };
      font = {
        size = 14;
        normal = {
          family = "${font}";
          style = "Medium";
        };
        bold = {
          family = "${font}";
          style = "Bold";
        };
        italic = {
          family = "${font}";
          style = "Light italic";
        };
      };

      colors = {
        primary = {
          background = "0x${bg}";
          foreground = "0x${fg}";
        };
        cursor = {
          text = "0x${bg}";
          cursor = "0x${c6}";
        };

        normal = {
          black = "0x${c0}";
          red = "0x${c1}";
          green = "0x${c2}";
          yellow = "0x${c3}";
          blue = "0x${c4}";
          magenta = "0x${c6}";
          cyan = "0x${c5}";
          white = "0x${fg}";
        };

        bright = {
          black = "0x${c8}";
          red = "0x${c9}";
          green = "0x${c10}";
          yellow = "0x${c11}";
          blue = "0x${c12}";
          magenta = "0x${c14}";
          cyan = "0x${c13}";
          white = "0x${fg}";
        };


      };
    };
  };
}