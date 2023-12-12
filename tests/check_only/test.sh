#!/usr/bin/env bash
set -euo pipefail

. "$REPO_ROOT/tests/util.bash"

run mako -C builder clean

# Expect it's built.
run mako -C builder
expect_eq_si "$(< ./builder/genfiles/output_file)" <<<"ran"
expect ! [[ -e genfiles/never_actually_built ]]

# Expect it's not built again with no change.
run mako -C builder
expect_eq_si "$(< ./builder/genfiles/output_file)" <<<"ran"
expect ! [[ -e genfiles/never_actually_built ]]

# Expect builder is built again now that internal.code is touched, but expect
# that internal still wasn't built.
touch ./internal/internal.code
run mako -C builder
expect_eq_si "$(< ./builder/genfiles/output_file)" <<EOF
ran
ran
EOF
expect ! [[ -e genfiles/never_actually_built ]]

run mako -C builder clean clean_deps
expect ! [[ -e ./builder/genfiles ]]

