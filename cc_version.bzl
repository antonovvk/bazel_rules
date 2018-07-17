def cc_version(name, visibility=None):
    gen = native.genrule(
        name = name + "_gen",
        cmd = "perl -ne 'if (m/([A-Z_]+) (.*)/) {print \"#define $$1 \\\"$$2\\\"\\n\";}' < ./bazel-out/stable-status.txt > \"$@\"",
        srcs = [],
        outs = [name + ".h"],
        stamp = 1,
        visibility = ["//visibility:private"],
    )

    native.cc_library(
        name = name,
        hdrs = [name + ".h"],
        visibility = visibility,
    )
