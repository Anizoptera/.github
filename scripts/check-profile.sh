#!/usr/bin/env sh
set -eu

die() {
  printf 'check-profile: %s\n' "$*" >&2
  exit 1
}

[ -f profile/README.md ] || die "missing profile/README.md"
[ -s profile/README.md ] || die "profile/README.md is empty"
[ -f AGENTS.md ] || die "missing AGENTS.md"
[ -f justfile ] || die "missing justfile"

canonical_positioning="Anizoptera is an independent engineering lab for durable software systems, developer infrastructure, tools, and open-source libraries."
grep -Fq "$canonical_positioning" profile/README.md || die "profile README missing canonical lab positioning"

git ls-files |
while IFS= read -r tracked_path; do
  case "$tracked_path" in
    .env|*/.env|*.env|*.pem|*.key|*.p12|*.pfx|*id_rsa*|*id_ed25519*)
      die "tracked path looks like a secret or local credential: $tracked_path"
      ;;
  esac
done

printf 'check-profile: ok\n'
