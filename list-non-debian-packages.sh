#!/bin/sh
sudo apt list '?narrow(?installed, ?not(?origin(Debian)))'
