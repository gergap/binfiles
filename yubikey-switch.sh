#!/bin/bash
# When switching to a different yubikey with the same subkeys
# gpg-agent wont use it due to the different serial.
# This makes it learn the new serial, so whenever switching
# yubikeys just execute this command.
gpg-connect-agent "scd serialno" "learn --force" /bye
