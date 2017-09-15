def _git_version_impl(ctx):
    output = ctx.outputs.out

    # --work-tree {root} is a hack to execute 'git describe' in actual source tree, not in temp environment
    root = str(ctx.file.repo.root)[:-8]

    cmd = """
        echo -n '{pref}' > {file}
        git --work-tree {root} describe --always --dirty | perl -pe 's/(.*)\\n/$1/' >> {file}
        echo -n '{suff}' >> {file}
    """.format(root=root, pref=ctx.attr.pref, suff=ctx.attr.suff, file=output.path)

    ctx.action(
        outputs = [output],
        inputs = [ctx.file.repo],
        progress_message = 'Generating Git version string',
        use_default_shell_env = True,
        command = cmd
    )

git_version_rule = rule(
    implementation = _git_version_impl,
    attrs = {
        "repo": attr.label(mandatory=True, allow_files=True, single_file=True),
        "output": attr.string(mandatory=True),
        "pref": attr.string(mandatory=True),
        "suff": attr.string(mandatory=True),
    },
    outputs = {"out": "%{output}"},
    output_to_genfiles = True,
)

def cc_git_version(repo, visibility=None):
    output = 'cc_git_version.h'
    config = git_version_rule(
        name = 'cc_git_version_impl',
        repo =  repo,
        output = output,
        pref = '#pragma once\nnamespace git_version {\ninline const char* GitVersion() {\nreturn "',
        suff = '";\n}\n} //namespace git_version\n\n',
    )

    native.cc_library(
        name = 'cc_version',
        hdrs = [output],
        visibility = visibility,
    )
