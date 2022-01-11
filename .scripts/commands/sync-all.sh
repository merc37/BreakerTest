#!/bin/bash
./pull-all && git push --recurse-submodules && exit 0
exit 1
