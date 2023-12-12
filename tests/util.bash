
function ok() {
  echo OK
}

function expect_eq() {
  lhs="${1:?}"
  rhs="${2:?}"
	if [[ "$lhs" != "$rhs" ]]; then
    {
      echo "FAILURE: lhs != rhs"
      echo lhs:
      echo "$lhs" | sed 's/^/  /'
      echo rhs:
      echo "$rhs" | sed 's/^/  /'
    } >&2
		return 1
	fi
  ok
}

function expect_eq_fi() {
  expect_eq "$(< "${1:?}")" "$(cat)"
}

function expect_eq_si() {
  expect_eq "${1:?}" "$(cat)"
}

function expect() {
	{ eval "$@"; } && ok || {
		echo "${BASH_SOURCE[0]}:${BASH_LINENO[0]}: FAILURE: expected $@" >&2
		return 1
	}
}

function run() {
  ${DEBUG:-false} && { eval "$@"; } || {
    eval "$@" &> /dev/null || {
      echo FAILURE, running again to get error messages.
      eval "$@"
      return $?
    }
  }
}

