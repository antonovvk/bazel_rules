load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("//:version.bzl", "git_version_rule")

def go_git_version(name, git_dir, visibility=None):
    output = name + ".go"
    config = git_version_rule(
        name = name + "_impl",
        index = git_dir + '/index',
        output = output,
        pref = 'package {name}\nvar GitVersion string = '.format(name=name),
        suff = '\n\n'
    )

    go_library(
        name = name,
        srcs = [output],
        visibility = visibility,
    )
