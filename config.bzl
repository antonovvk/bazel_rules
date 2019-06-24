def _set_header_impl(ctx):
    output = ctx.outputs.out

    ctx.actions.write(
        output = output,
        content = ctx.attr.data
    )

set_header_rule = rule(
    implementation = _set_header_impl,
    attrs = {
        "data": attr.string(mandatory=True),
        "file": attr.string(mandatory=True),
    },
    outputs = {"out": "%{file}"},
    output_to_genfiles = True,
)

def cc_set_header(name, file, data, visibility=None):
    config = set_header_rule(
        name = name + "_impl",
        file = file,
        data = data,
    )

    native.cc_library(
        name = name,
        hdrs = [file],
        visibility = visibility,
    )

def _gen_config_impl(ctx):
    output = ctx.outputs.out

    content = ""
    for k, v in ctx.attr.values.items():
        content += "#define %s %s\n" % (k, v)

    ctx.actions.write(
        output = output,
        content = content
    )

gen_config_rule = rule(
    implementation = _gen_config_impl,
    attrs = {
        "values": attr.string_dict(mandatory=True),
        "file": attr.string(mandatory=True),
    },
    outputs = {"out": "%{file}"},
    output_to_genfiles = True,
)

def cc_gen_config(name, file, values, visibility=None):
    config = gen_config_rule(
        name = name + "_impl",
        file = file,
        values = values,
    )

    native.cc_library(
        name = name,
        hdrs = [file],
        visibility = visibility,
    )

def _fix_config_impl(ctx):
    input = ctx.file.file
    output = ctx.outputs.out

    script = ""
    for k, v in ctx.attr.values.items():
        v = v.replace('\\', '\\\\').replace('/', '\\/')
        if ctx.attr.cmake:
            script += r"s/\#cmakedefine\s+%s\b.*/\#define %s %s/g;" % (k, k, v)
            script += r"s/\#cmakedefine01\s+%s\b.*/\#define %s 1/g;" % (k, k)
            script += r"s/\$\{%s\}/%s/g;" % (k, v)
        script += r"s/\@%s\@/%s/g;" % (k, v)

    if ctx.attr.cmake:
        script += r"s/\#cmakedefine[\s]+(\w+).*/\/* #undef \1 *\//g;"
        script += r"s/\#cmakedefine01[\s]+(\w+).*/\#define \1 0/g;"
        script += r"s/\$\{\w+\}//g;"
    script += r"s/\@[^\@]*\@/0/g"

    ctx.actions.run_shell(
        inputs = [input],
        outputs = [output],
        progress_message = "Configuring %s" % input.short_path,
        command = "perl -pe '%s' < %s > %s" % (script, input.path, output.path)
    )

fix_config_rule = rule(
    implementation = _fix_config_impl,
    attrs = {
        "file": attr.label(
            mandatory=True,
            allow_single_file=True,
        ),
        "cmake": attr.bool(default=False, mandatory=False),
        "output": attr.string(mandatory=True),
        "values": attr.string_dict(mandatory=True),
    },
    outputs = {"out": "%{output}"},
    output_to_genfiles = True,
)

def cc_fix_config(name, files, values, cmake=False, visibility=None):
    hdrs = []
    for input, output in files.items():
        fix_config_rule(
            name = input + "_impl",
            file = input,
            cmake = cmake,
            output = output,
            values = values,
        )
        hdrs.append(output)

    native.cc_library(
        name = name,
        hdrs = hdrs,
        visibility = visibility,
    )
