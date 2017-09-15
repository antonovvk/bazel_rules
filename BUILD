load("@io_bazel_rules_go//go:def.bzl", "gazelle", "go_prefix")

go_prefix("")

gazelle(
    name = "gazelle",
    prefix = "",
)

filegroup(
    name = "git",
    srcs = [
        ".git/index",
    ],
    visibility = ["//visibility:public"],
)
