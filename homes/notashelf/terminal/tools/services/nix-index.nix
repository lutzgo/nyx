{inputs, ...}: {
  imports = [inputs.nix-index-db.hmModules.nix-index];

  config = {
    programs = {
      nix-index = {
        enable = true;

        # link nix-inde database to ~/.cache/nix-index
        symlinkToCacheHome = true;
      };
      nix-index-database.comma.enable = true;
    };
  };
}
