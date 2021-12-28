#!/bin/bash

PWD=$(pwd)
home=~

function link() {
  from=$1
  to=$2

  mkdir -p ${from%\/*}

  if [ "${to}" != "$(readlink ${from})" ]; then
    if [ ! -e ${from} ]; then
      mv "${from}" "${from}.bck"
    fi
  
    ln -s "${to}" "${from}"
  fi
}

link "${home}/.vimrc" "${PWD}/vimrc"
link "${home}/.config/starship.toml" "${PWD}/starship.toml"

