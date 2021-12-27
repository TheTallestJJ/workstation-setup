#!/bin/bash

PWD=$(pwd)

if [ "${PWD}/vimrc" != "$(readlink ~/.vimrc)" ]; then
  if [ ! -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bac
  fi

  ln -s ${PWD}/vimrc ~/.vimrc
fi
