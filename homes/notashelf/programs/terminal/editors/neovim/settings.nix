{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix fileContents removeSuffix;
  inherit (lib.attrsets) genAttrs;

  nvf = inputs.neovim-flake;
in {
  config = {
    programs.neovim-flake = {
      enable = true;

      defaultEditor = true;
      enableManpages = true;

      settings = {
        vim = {
          # use neovim-unwrapped from nixpkgs
          # alternatively, neovim-nightly from the neovim-nightly overlay
          # via inputs.neovim-nightly.packages.${pkgs.system}.neovim
          package = pkgs.neovim-unwrapped;

          viAlias = true;
          vimAlias = true;

          preventJunkFiles = true;
          useSystemClipboard = true;
          spellcheck.enable = true;

          enableLuaLoader = true;
          enableEditorconfig = true;

          debugMode = {
            enable = false;
            logFile = "/tmp/nvim.log";
          };

          additionalRuntimePaths = [
            ./runtime
          ];

          luaConfigRC = let
            inherit (nvf.lib.nvim.dag) entryAnywhere;

            # get the name of each lua file in the lua directory, where setting files reside
            configPaths = map (f: removeSuffix ".lua" f) (filter (hasSuffix ".lua") (map toString (listFilesRecursive ./lua)));

            # get the path of each file by removing the ./. prefix from each element in the list
            configNames = map (p: removeSuffix "./" p) configPaths;

            # generates a key-value pair that looks roughly as follows:
            # "fileName" = entryAnywhere "<contents of ./lua/fileName.lua>"
            # which is expected by neovim-flake's modified DAG library
            luaConfig = genAttrs configNames (name:
              entryAnywhere ''
                ${fileContents "${name}.lua"}
              '');
          in
            luaConfig;
        };
      };
    };
  };
}
