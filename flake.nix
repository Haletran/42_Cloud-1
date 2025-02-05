{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ansible-env";
  buildInputs = [
    pkgs.python3
    pkgs.ansible
  ];

  shellHook = ''
    echo "Ansible environment is ready!"
    ansible --version
  '';
}
