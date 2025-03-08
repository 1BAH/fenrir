# Fenrir v0.4.0

> Framework for testing

## Install

### System requirements

* Unix-like OS
* `jq`
* `wget`
* `shellcheck`

### Installation

1. Clone this repository
2. Go to `src/main/fenrir/cli`
3. Run `./install-fenrir`

## Uninstall

* Clone this repository
* Go to `src/main/fenrir/cli`
* Run `./uninstall-fenrir`

## Usage

```
Possible options:
fenrir help

fenrir gc
fenrir remote <URL>
fenrir task [-s] <TASK ID>
fenrir run [-s] <SOLUTION DIR>

fenrir [-v|--version|version]
fenrir version
fenrir versions
fenrir switch [<VERSION> | latest]
------------------------------------------------------------------
fenrir help:
    Info about fenrir util
    See https://gitlab.com/atpd/progtech/fenrir

fenrir remote <URL>:
    Set remote task repository

fenrir task [-s] [-f|--force] <TASK ID>:
    Set task tests. If they have not been installed yet then install then.
    '-f' or '--force': Install anyway
    '-s': Mute colours

fenrir run [-s] <SOLUTION DIR>:
    Run local tests on the specified local repository
    '-s': Mute colours

fenrir gc:
    Clean local repository. Removes all installed tasks and dependencies, fenrir-tmp.

fenrir versions:
    Get all available versions

fenrir switch [-s] latest:
    Update up to the latest version
    '-s': Mute colours

fenrir switch <VERSION>:
    Switch to the specified version (Error is thrown if the version is not available)
    Run 'fenrir version' to list all available versions

fenrir version:
    Print current version

fenrir [-v|--version|version]:
    Print current version
```

## Updates

All updates are published [here](https://t.me/fenrir_updates)

---

Authors:

* Iwan Kalinin
