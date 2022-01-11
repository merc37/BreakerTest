#!/bin/bash
git pull --recurse-submodules && stage-unv && git annex sync --content && exit 0
exit 1
