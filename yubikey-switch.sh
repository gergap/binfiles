#!/bin/bash
# When switching to a different yubikey the same subkeys
# gpg-agnet wont use it du to the different serial.
# This makes it learn the new serial, so whenever switching
# yubikeys just execute this command.
gpg-connect-agent "scd serialno" "learn --force" /bye
