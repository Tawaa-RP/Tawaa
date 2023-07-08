#!/bin/bash

source screen-irssi.sh

irssi_connect rss

irssi_join rss \#tawaa

irssi_chansend rss "$1"

irssi_exit rss
