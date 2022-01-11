#!/bin/bash
git fetch --recurse-submodules && stage-unv && git annex sync && exit 0
exit 1
