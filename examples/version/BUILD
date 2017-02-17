cc_binary(
    name = "cpp",
    srcs = [
        "main.cpp",
    ],
    deps = [
        "//:cc_version",
    ],
    copts = [
        "-std=c++11",
        "-Wall",
    ],
)

load("@io_bazel_rules_go//go:def.bzl", "go_binary")

go_binary(
    name = "go",
    srcs = [
        "main.go",
    ],
    deps = [
        "//:go_version",
    ],
)
