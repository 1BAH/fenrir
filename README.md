# Fenrir

> Framework for testing

![status](https://github.com/1bah/fenrir/actions/workflows/pages.yml/badge.svg)
![status](https://github.com/1bah/fenrir/actions/workflows/docker.yml/badge.svg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

> The project has migrated from [GitLab](https://gitlab.com/atpd/fenrir)

The latest version is `1.2.2`

Available in a docker container: `ghcr.io/1bah/fenrir/fenrir-base:latest`

## Install

### System requirements

* Bash version 5.0.0+
* `wget`

### Installation

1. Clone this repository
2. Go to `src/main/fenrir/cli`
3. Run `./install-fenrir`

> Install script supports these options:
> ```text
> --bash     Install autocompletion for bash
> --zsh      Install autocompletion for zsh
> -v       Verbose mode
> ```

If you use `zsh` without `Oh My Zsh` then make sure
1. `autoload -U compinit && compinit` is present at `~/.zshrc`
2. `~/.oh-my-zsh/completions` is present at `fpath`

## Uninstall

Run `uninstall-fenrir` in terminal

## Usage

#### Select custom task repository
```
fenrir-set-conf main remote REPOSITORY
```

#### Select task
```
fenrir task TASK_ID
```

Use `-f` flag to force-update task tests

#### Run tests
```
fenrir run PATH_TO_SOLUTION_REPO
```

Available flags:
- `-i` -> `inline`: do not clone the solution, run tests inside the provided repo
- `-nl` -> `no linters`: skip all linters
- `-c TEST_NAME` -> run only the selected test

#### Run tests in a docker container
```
fenrir rund TEST_NAME
```
Flags `-nl` and `-c` are supported

#### See test sources
```
fenrir inspect TEST_NAME
```

To change the preview app, replace `FENRIR_EDITOR="less"` in `/etc/fenrir/lokirc`


## Updates

All updates are published [here](https://t.me/fenrir_updates)

---

Authors:

* Iwan Kalinin (koefic.cien@gmail.com)
