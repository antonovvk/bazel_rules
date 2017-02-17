# Taken from https://github.com/korfuri/grpc-bazel
# This is a workaround for native protobuf cc_proto_library rule not working when use_grpc_plugin=True (at least in protobuf-3.1.0)

proto_filetype = FileType(['.proto'])

def cc_proto_library(name, src, has_service = False, **kargs):
    basename = src[0:-5]

    command = '$(location @protobuf//:protoc) --cpp_out=$(GENDIR)/'
    command += ' $(location %s);' % (src)

    cc_proto_name = name + '_cc_proto'
    header_outputs = [basename + 'pb.h']
    outputs = header_outputs + [basename + 'pb.cc']

    native.genrule(
        name = cc_proto_name,
        srcs = [ src ],
        cmd = command,
        outs = outputs,
        tools = ['@protobuf//:protoc'],
    )

    if has_service:
        grpc_command = '$(location @protobuf//:protoc) --grpc_out=$(GENDIR)/'
        grpc_command += ' --plugin=protoc-gen-grpc=$(location @grpc//:grpc_cpp_plugin)'
        grpc_command += ' $(location %s);' % (src)

        grpc_cc_proto_name = name + '_cc_proto_service'
        grpc_header_outputs = [basename + 'grpc.pb.h']
        grpc_outputs = grpc_header_outputs + [basename + 'grpc.pb.cc']
        grpc_extra_srcs = [':' + grpc_cc_proto_name]
        grpc_extra_deps = [
            '@grpc//:grpc++',
        ]

        native.genrule(
            name = grpc_cc_proto_name,
            srcs = [ src ],
            cmd = grpc_command,
            outs = grpc_outputs,
            tools = [
              '@protobuf//:protoc',
              '@grpc//:grpc_cpp_plugin',
            ],
        )
    else:
        grpc_header_outputs = []
        grpc_extra_srcs = []
        grpc_extra_deps = []

    native.cc_library(
        name = name,
        hdrs = header_outputs + grpc_header_outputs,
        srcs = [ ':' + cc_proto_name ] + grpc_extra_srcs,
        deps = [ '@protobuf//:protobuf', ] + grpc_extra_deps,
        **kargs
    )

load("@io_bazel_rules_go//go:def.bzl", "go_library")

def go_proto_library(name, src, has_service = False, **kargs):
    basename = src[0:-5]


    go_proto_name = name + '_go_proto'
    output = basename + 'pb.go'
    tools = ['@protobuf//:protoc']
    command = '$(location @protobuf//:protoc) --plugin=$(location @com_github_golang_protobuf//protoc-gen-go) --go_out=' % ()

    if has_service:
        tools += ['@com_github_golang_protobuf//protoc-gen-go']
        command += 'plugins=grpc,'
        grpc_extra_deps = [
            '@org_golang_x_net//context:go_default_library',
            '@org_golang_google_grpc//:go_default_library',
        ]
    else:
        grpc_extra_deps = []

    command += ':$(GENDIR)/ $(location %s);' % (src)

    native.genrule(
        name = go_proto_name,
        srcs = [ src ],
        cmd = command,
        outs = [ output ],
        tools = tools,
    )

    go_library(
        name = name,
        srcs = [ output ],
        deps = [ '@com_github_golang_protobuf//proto:go_default_library', ] + grpc_extra_deps,
        **kargs
    )
