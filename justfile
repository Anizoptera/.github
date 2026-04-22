default:
    just --list

bootstrap:
    git config core.hooksPath .githooks
    just check

check:
    ./scripts/check-profile.sh
    shellcheck scripts/*.sh .githooks/*
