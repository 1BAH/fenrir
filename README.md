# Fenrir

> Framework for testing

## Custom testing scenarios' scripts convention

* Arguments


| Argument | Description    |
| -------- | -------------- |
| $1       | repo link      |
| $2       | verbosity flag |

* Solution's repo directory - `/home/checker/solution`
* To add points use cli command `add-points [points]`
* Configs are located in `/etc/fenrir/`

## Custom inspections during directory traversal

* Arguments


| Argument | Description      |
| -------- | ---------------- |
| $1       | file's full path |
| $2       | verbosity flag   |

## Building images

Inside `src/main` there is a build script: `build.sh`. Usage:

```
./build.sh <image name> [image tag] [.+/l]
    <image name> - the name of image, e.g. 'task-git'
    <image tag>  - OPTIONAL version (default value is '0.0.1'), e.g. '2025.0'
    [l]          - OPTIONAL push latest tag to docker hub
    [.+]         - OPTIONAL (any nonempty string) push provided tag to docker hub
```

The results are:

- `registry.akhcheck.ru/$name:$tag`
- `taekwandodo/$name:$tag` (Supported arm64 & amd64 architectures)

---

Authors:

* Iwan Kalinin
