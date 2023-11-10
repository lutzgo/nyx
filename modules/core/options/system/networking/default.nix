{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  imports = [./nftables.nix];
  options.modules.system.networking = {
    nftables.enable = mkEnableOption "nftables firewall";
    optimizeTcp = mkEnableOption "TCP optimizations";

    tailscale = {
      client.enable = mkEnableOption "Tailscale for inter-machine VPN.";
      server.enable = mkEnableOption ''
        Tailscale inter-machine VPN exit node.

        This option is mutually exlusive with {option}`tailscale.client.enable` as they both
        configure Taiscale, but with different flags
      '';
    };

    wirelessBackend = mkOption {
      type = types.enum ["iwd" "wpa_supplicant"];
      default = "iwd";
      description = ''
        Backend that will be used for wireless connections using either `networking.wireless`
        or `networking.networkmanager.wifi.backend`

        Defaults to wpa_supplicant until iwd is stable.
      '';
    };

    # TODO: optionally use encrypted DNS
    # encryptDns = mkOption {};
  };
}