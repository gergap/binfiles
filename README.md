# The repository contains useful scripts I have installed into ~/bin

Overview:

* antiword: converts MS doc files to PDF and opens it.
* connect/disconnect headphone: for more Bluetooth headphones
* file_template: A file template script I use in Vim for creating new files.
* git-credential-pass: integrates pass credentials into git (e.g. for `git sendemail`)
* inst_perl: wrapper to install perl packages via apt
* mailsync: calls mbsync and notmuch. I use neomutt on this local IMAP cache.
* nodeid: lookup UA nodeids
* passmenu: dmenu integration for pass. This can also type login and password for you.
* statusbar: a simple statusbar for dwm
* statuscode: lookup UA statuscodes
* viml: A wrapper for Vim which allows me to open files like `vim /path/to/file:1234` at the correct line number.
  This is convenient to open files printed in compiler output.
* der2pem: converts X509v3 certificates from DER encoding to PEM
* pem2der: converts X509v3 certificates from PEM encoding to DER

## CCache on tmpfs

Overview: These scripts help to move .ccache on a fast tmpfs (RAM disk).
On shutdown all files will be archived in the persistent folder .ccache-persistent.
On startup the tmpfs gets mounted and the cache gets restored from the persistent folder.


### Files

* ccache-make-persistent: Make the current .ccache persistent
* ccache-enable-tmpfs: Restores the .ccache
* ccache-ramdisk.service: Systemd user unit file which handles invocation of the BASH scripts.

### Installation

1. Create the directory ~/bin and move the files above to this folder.
2. Create the systemd config directory and install the unit file.

```
    mkdir ~/.config/systemd/user/
    ln -s ~/bin/ccache-ramdisk.service ~/.config/systemd/user/ccache-ramdisk.service
    sudo systemctl --user daemon-reload
    sudo systemctl --user enable ccache-ramdisk
    sudo systemctl --user start ccache-ramdisk
```

4. Edit /etc/fstab and add the following entry:

```
    # put ccache on tmpfs
    none /home/<username>/.ccache tmpfs defaults,noauto,user 0 2
```

