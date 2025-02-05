{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ansible-env";
  buildInputs = [
    pkgs.python3
    pkgs.ansible
	pkgs.sshpass 
	pkgs.glibcLocales
  ];

  shellHook = ''
	#export LC_ALL=en_US.UTF-8
	#export LANG=en_US.UTF-8

    echo "Ansible environment is ready!"
    ansible --version
  '';
}
