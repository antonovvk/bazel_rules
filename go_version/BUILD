load("@io_bazel_rules_go//go:def.bzl", "go_library")

go_library(
    name = "go_default_library",
    srcs = ["version.go"],
    importpath = "github.com/antonovvk/bazel_rules/go_version",
    visibility = ["//visibility:public"],
    x_defs = {
        "github.com/antonovvk/bazel_rules/go_version.GitVersion": "{STABLE_GIT_TAG}",
        "github.com/antonovvk/bazel_rules/go_version.BuildDate": "{STABLE_BUILD_DATE}",
        "github.com/antonovvk/bazel_rules/go_version.BuildUser": "{BUILD_USER}",
        "github.com/antonovvk/bazel_rules/go_version.BuildHost": "{BUILD_HOST}",
    },
)
