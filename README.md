# Fenrir v1.0.0

> Framework for testing

## Install

### System requirements

* Bash version 5.0.0+
* `wget`

### Installation

1. Clone this repository
2. Go to `src/main/fenrir/cli`
3. Run `./install-fenrir`

## Uninstall

> TODO

## Usage

```
Possible options:
fenrir help
fenrir i
fenrir info

fenrir gc
fenrir remote <URL>
fenrir task [-f|--force] <TASK ID>
fenrir run [-i] [-nl|--no-lint] [-nz|--no-zero] <SOLUTION DIRECTORY>
fenrir-rund [-d|--debug] [-nl|--no-lint] [-nz|--no-zero] <SOLUTION DIRECTORY>

fenrir v
fenrir version
fenrir versions
------------------------------------------------------------------
fenrir help:
    Info about fenrir util
    See https://gitlab.com/atpd/fenrir

fenrir i, info:
    Show the current context of fenrir:
      - Tasks' remote repo
      - The task to be tested
      - Running mode of the task (whether is blocking or not)
      - Testing pipeline

fenrir remote <URL>:
    Set remote task repository

fenrir task [-f|--force] <TASK ID>
    Set the task to be checked and optionally download its tests.
    The tests are downloaded from 'remote' which is defined in '/etc/fenrir/main.hel'.
    When the task tests have already been downloaded, the corresponding stages is omitted.
    Options:
       none            Download tests only when they are not presented
       -f, --force     Download tests anyway

fenrir run [-i] [-nl|--no-lint] [-nz|--no-zero] <SOLUTION DIRECTORY>
    Test the provided solution. The test must be set beforehand with 'fenrir-task' command.
    This command is an interface. For the detailed execution pipeline see 'fenrir-main'.
    Options:
       -i                 Run test inside the provided directory without cloning it
                          WARNING! In case of test's impurity it might produce some side-effects
      -nz, --no-zero      Skip task0 validation
      -nl, --no-lint      Skip linting stage (walk-inspections)

fenrir-rund [-d|--debug] [-nl|--no-lint] [-nz|--no-zero] <SOLUTION DIRECTORY>
    Starts a container and executes 'fenrir-run' inside.
    After the execution the container is removed unless the 'debug' flag is set.
    Options:
       -d, --debug        Does not stop the container (allows further debug)
      -nz, --no-zero      Skip task0 validation
      -nl, --no-lint      Skip linting stage (walk-inspections)

fenrir gc [-f|--force]:
    Removes unused files. Has two modes: SOFT and HARD. The default is 'SOFT'
    Soft:
        - temporary files
    Hard:
        - temporary files
        - local repo
        - local configs

fenrir versions:
    Get all available versions

fenrir v, version:
    Print current version
```

## Updates

All updates are published [here](https://t.me/fenrir_updates)

---

Authors:

* Iwan Kalinin (koefic.cien@gmail.com)
