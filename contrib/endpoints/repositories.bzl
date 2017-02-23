# Copyright 2016 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
#
def zlib_repositories(bind=True):
    BUILD = """
# Copyright 2016 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
#

licenses(["notice"])

exports_files(["README"])

cc_library(
    name = "zlib",
    srcs = [
        "adler32.c",
        "crc32.c",
        "crc32.h",
        "deflate.c",
        "deflate.h",
        "infback.c",
        "inffast.c",
        "inffast.h",
        "inffixed.h",
        "inflate.c",
        "inflate.h",
        "inftrees.c",
        "inftrees.h",
        "trees.c",
        "trees.h",
        "zconf.h",
        "zutil.c",
        "zutil.h",
    ],
    hdrs = [
        "zlib.h",
    ],
    copts = [
        "-Wno-shift-negative-value",
        "-Wno-unknown-warning-option",
    ],
    defines = [
        "Z_SOLO",
    ],
    visibility = [
        "//visibility:public",
    ],
)
"""

    native.new_git_repository(
        name = "zlib_git",
        build_file_content = BUILD,
        commit = "50893291621658f355bc5b4d450a8d06a563053d",  # v1.2.8
        remote = "https://github.com/madler/zlib.git",
    )

    native.bind(
        name = "zlib",
        actual = "@zlib_git//:zlib"
    )

def nanopb_repositories(bind=True):
    BUILD = """
# Copyright 2016 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
#

licenses(["notice"])

exports_files(["LICENSE.txt"])

cc_library(
    name = "nanopb",
    srcs = [
        "pb.h",
        "pb_common.c",
        "pb_common.h",
        "pb_decode.c",
        "pb_decode.h",
        "pb_encode.c",
        "pb_encode.h",
    ],
    hdrs = [":includes"],
    visibility = [
        "//visibility:public",
    ],
)

genrule(
    name = "includes",
    srcs = [
        "pb.h",
        "pb_common.h",
        "pb_decode.h",
        "pb_encode.h",
    ],
    outs = [
        "third_party/nanopb/pb.h",
        "third_party/nanopb/pb_common.h",
        "third_party/nanopb/pb_decode.h",
        "third_party/nanopb/pb_encode.h",
    ],
    cmd = "mkdir -p $(@D)/third_party/nanopb && cp $(SRCS) $(@D)/third_party/nanopb",
)
"""

    native.new_git_repository(
        name = "nanopb_git",
        build_file_content = BUILD,
        commit = "f8ac463766281625ad710900479130c7fcb4d63b",
        remote = "https://github.com/nanopb/nanopb.git",
    )

    native.bind(
        name = "nanopb",
        actual = "@nanopb_git//:nanopb",
    )

def grpc_repositories(bind=True):
    zlib_repositories(bind)
    nanopb_repositories(bind)

    native.git_repository(
        name = "grpc_git",
        commit = "bb3edafea245a9780cc4c10f0b58da21e8193f38", # v1.1.1
        remote = "https://github.com/grpc/grpc.git",
    )

    if bind:
        native.bind(
            name = "gpr",
            actual = "@grpc_git//:gpr",
        )

        native.bind(
            name = "grpc",
            actual = "@grpc_git//:grpc",
        )

        native.bind(
            name = "grpc_cpp_plugin",
            actual = "@grpc_git//:grpc_cpp_plugin",
        )

        native.bind(
            name = "grpc++",
            actual = "@grpc_git//:grpc++",
        )

        native.bind(
            name = "grpc_lib",
            actual = "@grpc_git//:grpc++_codegen_proto",
        )


def servicecontrol_client_repositories(bind=True):

    native.git_repository(
        name = "servicecontrol_client_git",
        commit = "069bc7156d92a2d84929309d69610c76f6b8dab9",
        remote = "https://github.com/cloudendpoints/service-control-client-cxx.git",
    )

    if bind:
        native.bind(
            name = "servicecontrol_client",
            actual = "@servicecontrol_client_git//:service_control_client_lib",
        )
        native.bind(
            name = "servicecontrol",
            actual = "@servicecontrol_client_git//proto:servicecontrol",
        )

        native.bind(
            name = "servicecontrol_genproto",
            actual = "@servicecontrol_client_git//proto:servicecontrol_genproto",
        )

        native.bind(
            name = "service_config",
            actual = "@servicecontrol_client_git//proto:service_config",
        )

        native.bind(
            name = "cloud_trace",
            actual = "@servicecontrol_client_git//proto:cloud_trace",
        )
