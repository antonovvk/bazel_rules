## Git Version support for bazel build

This package defines rules to supply git version and build time info for cc_* and go_* targets.

All version rules require a special filegroup to be defined in root BUILD file:

```
filegroup(
    name = "git_repo",
    srcs = [
        ".git/index",
    ],
    visibility = ["//visibility:public"],
)
```

To override cached build timestamp use

```
bazel build --define="BUILD_TIMESTAMP=`date`"  ...
```
