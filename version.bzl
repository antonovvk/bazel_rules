def _git_version_impl(ctx):
    output = ctx.outputs.out

    cmd = """
        echo -n '{pref}' > {file}
        git --work-tree ./ describe --always --dirty | perl -pe 's/(.*)\\n/"$1"/' >> {file}
        echo '{suff}' >> {file}
    """.format(pref=ctx.attr.pref, suff=ctx.attr.suff, file=output.path)

    ctx.action(
        outputs = [output],
        inputs = [ctx.file.index],
        progress_message = 'Generating Git version string',
        use_default_shell_env = True,
        command = cmd
    )

git_version_rule = rule(
    implementation = _git_version_impl,
    attrs = {
        "index": attr.label(mandatory=True, allow_files=True, single_file=True),
        "output": attr.string(mandatory=True),
        "pref": attr.string(mandatory=True),
        "suff": attr.string(mandatory=True),
    },
    outputs = {"out": "%{output}"},
    output_to_genfiles = True,
)

def cc_git_version(name, git_dir, visibility=None):
    output = name + ".h"
    config = git_version_rule(
        name = name + "_impl",
        index = git_dir + '/index',
        output = output,
        pref = '#pragma once\nnamespace {ns} {{\ninline const char* GitVersion() {{\nreturn '.format(ns=name),
        suff = ';\n}}\n}} //namespace {ns}\n\n'.format(ns=name),
    )

    native.cc_library(
        name = name,
        hdrs = [output],
        visibility = visibility,
    )

load("@io_bazel_rules_go//go:def.bzl", "go_library")
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
