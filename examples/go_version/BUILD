load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_binary(
    name = "go_version",
    embed = [":go_default_library"],
    visibility = ["//visibility:public"],
)

go_library(
    name = "go_default_library",
    srcs = ["main.go"],
    importpath = "github.com/antonovvk/bazel_rules/examples/go_version",
    visibility = ["//visibility:private"],
    deps = ["//go_version:go_default_library"],
)
