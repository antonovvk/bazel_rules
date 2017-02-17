load("@io_bazel_rules_go//go:def.bzl", "go_prefix")
go_prefix("")

load("//:version.bzl", "cc_git_version")
load("//:go_version.bzl", "go_git_version")
cc_git_version("cc_version", ".git", visibility = ["//visibility:public"])
go_git_version("go_version", ".git", visibility = ["//visibility:public"])
