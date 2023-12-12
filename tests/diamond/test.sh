#!/usr/bin/env bash
set -euo pipefail

. $REPO_ROOT/tests/util.bash

mako -j 4 -C deployment clean clean_deps
mako -j 4 -C deployment

expect_eq_fi ./deployment/genfiles/bring_it_up_log <<EOF
--bringing up deployment--

==client==
--proto lang2--
service Foo {
  rpc Bar(Stuff) returns (Stuff);
}
message Stuff { }
slow write 1
slow write 2
slow write 3
-- client lang2 source code --
foo bar
====

==server==
--proto lang1--
service Foo {
  rpc Bar(Stuff) returns (Stuff);
}
message Stuff { }
slow write 1
slow write 2
slow write 3
-- server lang1 source code --
foo bar
====
EOF

mako -j 4 -C deployment clean clean_deps
expect ! [[ -e proto/genfiles ]]
expect ! [[ -e server/genfiles ]]
expect ! [[ -e client/genfiles ]]
expect ! [[ -e deployment/genfiles ]]

