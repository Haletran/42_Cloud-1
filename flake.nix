{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "cloud-1 env";
  buildInputs = [
    pkgs.python3
    pkgs.ansible
	  pkgs.sshpass 
	  pkgs.glibcLocales
    #pkgs.vagrant
  ];

  shellHook = ''
	  #export LC_ALL=en_US.UTF-8
	  #export LANG=en_US.UTF-8

    echo "Cloud-1 environment is ready!"
    ansible --version
    #vagrant --version
  '';
}
