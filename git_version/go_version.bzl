load("@io_bazel_rules_go//go:def.bzl", "go_embed_data", "go_library")
load("//git_version:version.bzl", "git_version_rule")

def go_git_version(repo, visibility=None):
    output = 'go_git_version.txt'
    config = git_version_rule(
        name = 'go_git_version_data',
        repo =  repo,
        output = output,
        pref = '',
        suff = ''
    )

    go_embed_data(
        name = 'go_git_version_impl',
        src = output,
        out = 'go_git_version.go',
        package = 'git_version',
        string = True,
        var = "GitVersion",
    )

    go_library(
        name = 'go_default_library',
        srcs = ['go_git_version.go'],
        visibility = visibility,
    )
