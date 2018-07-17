load("//:cc_version.bzl", "cc_version")

cc_version(
    name = "version",
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "cc_version",
    srcs = ["main.cpp"],
    deps = ["version"],
    copts = [
        "-std=c++11",
        "-Wall",
    ],
    stamp = 1,
    visibility = ["//visibility:public"],
)
