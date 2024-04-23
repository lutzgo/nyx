# Notes for 2nd of April, 2024

I am gonna try to bootstrap a new System today.

The goal is to do this in style from my main machine.

Drop into the DevShell.

```
nix develop
```

Copy your local key to the remote machine.

```
ssh-copy-id -i /<path-to-key>/<name>_ed25519.pub -o PubkeyAuthentication=no -o PreferredAuthentications=password root@<remote-ip-addr>
```

Create a `secret.key` with a password in it in your `/tmp`.
This will be copied over so you can interacticly decrypt your LUKS-partition later.

```
touch /tmp/secret.key
echo -n "fairly-secret-password" > /tmp/secret.key
```

Generate a host-key-pair

```
mkdir -p /tmp/remote/persist/etc/ssh
chmod 755 /tmp/remote/persist/etc/ssh
ssh-keygen -q -N "" -t ed25519 -C <remote-host-name> -f /tmp/remote/persist/etc/ssh/ssh_host_ed25519_key
```

Create a user ssh-key and add it to your `secrets.nix`.

```
mkdir -p /tmp/remote/persist/home/.ssh
chmod 755 /tmp/remote/persist/home/.ssh
ssh-keygen -q -N "" -t ed25519 -C user -f /tmp/remote/persist/home/<user>/.ssh/id_ed25519_key
```

Add your keys to `secrets.nix` and describe your secrets.
```
cat /tmp/remote/persist/home/<user>/.ssh/id_ed25519_key.pub
cat /tmp/remote/persist/etc/ssh/ssh_host_ed25519_key.pub
```

Create your secrets e.g. user password with `mkpasswd -m sha-512` and write it in an age-file.
```
agenix -e <user>-system-pw.age -i /tmp/remote/persist/home/<user>/.ssh/id_ed25519_key
agenix -e root-system-pw.age -i /tmp/remote/persist/etc/ssh/host_ssh_ed25519_key
```

Install the System
```
sudo -i nix run github:numtide/nixos-anywhere -- \
  --ssh-port 22 --debug --no-reboot \
  -i </path/to/>.ssh/<hostname>_ed25519 \
  --disk-encryption-keys /tmp/secret.key /tmp/secret.key \
  --extra-files /tmp/remote/ \
  --flake </path/to/>/#<hostname> \
  root@<ip-addr>
```

