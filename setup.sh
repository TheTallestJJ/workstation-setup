#!/bin/bash

channel="nixos-21.11"
PWD=$(pwd)
home=~

function link() {
  from=$1
  to=$2
  
  echo -n "linking: ${to##*/}..."
  mkdir -p ${from%\/*}

  if [ "${to}" != "$(readlink ${from})" ]; then
    if [ -e ${from} ]; then
      echo -n "creating backup..."
      mv "${from}" "${from}.bck"
    fi
  
    ln -s "${to}" "${from}"

    echo "done"
  else
    echo "already in place"
  fi
}

function setup_fish_config() {
  local PWD=$1
  
  cp ${PWD}/config.fish.template ${PWD}/config.fish
  echo "" >> config.fish
  echo "set fish_function_path \$fish_function_path ${PWD}/plugin-foreign-env/functions" >> config.fish
  echo "" >> config.fish
  echo "fenv source /etc/profile.d/nix.sh" >> config.fish
  echo "" >> config.fish
  echo "set NIX_PATH $HOME/.nix-defexpr/channels" >> config.fish
}

if [ -z "$(which nix)" ]; then
  echo "No Nix!"
fi

nix-channel --add https://nixos.org/channels/nixos-21.11 nixpkgs
nix-channel --update

setup_fish_config $PWD

link "${home}/.config/nixpkgs/home.nix" "${PWD}/home.nix"
link "${home}/.config/fish/config.fish" "${PWD}/config.fish"
link "${home}/.vimrc" "${PWD}/vimrc"
link "${home}/.config/starship.toml" "${PWD}/starship.toml"

