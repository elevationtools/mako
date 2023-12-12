#!/usr/bin/env bash
set -euo pipefail

. "$REPO_ROOT/tests/util.bash"

mako -C app_container clean clean_deps
FOO=thefirstfoo mako -C app_container

expect_eq_si "$(docker run mako_tests/app_container cat \
    /mako_repo/tests/container/app_code/output)" <<EOF
This file represents source code that needs to be compiled.
The value of FOO is thefirstfoo
EOF

# Make sure the build didn't run on this host workstation.
expect ! test -e "app_code/genfiles/output"

# Check that the host machine did "check" the status of the app_code though.
expect test -e "app_code/genfiles/mako/check/default"

# Make sure the build doesn't run again (FOO is still "thefirstfoo")
FOO=thewrongfoo mako -C app_container
expect_eq_si "$(docker run mako_tests/app_container cat \
    /mako_repo/tests/container/app_code/output)" <<EOF
This file represents source code that needs to be compiled.
The value of FOO is thefirstfoo
EOF

# Make sure it's rebuilt if the source is touched.
touch app_code/pseudo_source
FOO=thethirdfoo mako -C app_container
expect_eq_si "$(docker run mako_tests/app_container cat \
    /mako_repo/tests/container/app_code/output)" <<EOF
This file represents source code that needs to be compiled.
The value of FOO is thethirdfoo
EOF


