#!/bin/bash
./.scripts/commands/pull-all.sh \
    && git push --recurse-submodules \
    && exit 0
exit 1
