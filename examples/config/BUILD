load("//:config.bzl", "cc_gen_config", "cc_fix_config", "cc_set_header")

cc_gen_config(
    name = "gen_cfg",
    file = "gen_cfg.h",
    values = {
        "FLAG": "",
        "VALUE": "\"CONFIGURED\"",
    },
    visibility = ["//visibility:private"],
)

cc_set_header(
    name = "set_header",
    file = "hello.h",
    data = "#define HELLO \"Hello World\"",
    visibility = ["//visibility:private"],
)

cc_binary(
    name = "gen",
    srcs = [
        "gen.cpp",
    ],
    deps = [
        ":gen_cfg",
    ],
    copts = [
        "-std=c++11",
        "-Wall",
    ],
)

cc_fix_config(
    name = "fix_config",
    files = {
        "foo.h.in": "foo.h",
        "bar.h.in": "bar.h",
    },
    values = {
        "FOOBAR": "1",
        "foo": "\"foo\"",
        "bar": "\"bar\"",
    },
    visibility = ["//visibility:private"],
)

cc_fix_config(
    name = "fix_cmake",
    cmake = True,
    files = {
        "jar.h.cmake": "jar.h",
    },
    values = {
        "JAR": "\"jar\"",
        "JOO": "1",
    },
    visibility = ["//visibility:private"],
)

cc_binary(
    name = "fix",
    srcs = [
        "fix.cpp",
    ],
    deps = [
        ":fix_config",
        ":fix_cmake",
        ":set_header",
    ],
    copts = [
        "-std=c++11",
        "-Wall",
    ],
)

