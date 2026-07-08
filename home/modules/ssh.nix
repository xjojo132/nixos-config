{
  pkgs,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;

    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";

      # macOS keychain integration for the key passphrase (was in ~/.ssh/config).
      extraOptions = lib.mkIf pkgs.stdenv.isDarwin {
        UseKeychain = "yes";
      };
    };
  };

  # ssh-agent as a user service uses systemd (Linux only); macOS uses launchd.
  services.ssh-agent.enable = lib.mkIf pkgs.stdenv.isLinux true;
}
