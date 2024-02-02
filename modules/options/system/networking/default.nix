{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  imports = [
    ./nftables.nix
    ./tailscale.nix
  ];
  options.modules.system.networking = {
    nftables.enable = mkEnableOption "nftables firewall";
    tarpit.enable = mkEnableOption "endlessh-go tarpit";
    optimizeTcp = mkEnableOption "TCP optimizations";

    wirelessBackend = mkOption {
      type = types.enum ["iwd" "wpa_supplicant"];
      default = "wpa_supplicant";
      description = ''
        Backend that will be used for wireless connections using either
        `networking.wireless` or `networking.networkmanager.wifi.backend`

        Defaults to wpa_supplicant until iwd is stable.
      '';
    };

    # TODO: optionally use encrypted DNS
    # encryptDns = mkOption {};
  };
}
