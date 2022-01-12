#!/bin/bash
src_dir=$( realpath "${BASH_SOURCE[0]}" | xargs -0 dirname )
function src_realpath() { (cd "$src_dir"; realpath "$1"); }
function src_source() { source "$(cd "$src_dir"; realpath "$1")"; }
function src_exec() { (cd "$src_dir"; $1) }
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# Arguments ---------------------------------------------------------
project_path=$(cd "$src_dir"; realpath "../..")
unity_path="/c/Program Files/Unity/Hub/Editor/2020.3.25f1/Editor/Unity.exe"

# Execute -----------------------------------------------------------
"$unity_path" \
    -projectPath "$project_path" \
    -quit -batchmode \
    -logfile - \
    -executeMethod BML.Build.Builder.BuildProjectCommandLine \
    -buildTarget StandaloneWindows64 \
    -overwriteMode Overwrite \
    -buildOptions Development \
    -buildOptions AutoRunPlayer
echo ""
echo "Unity Editor process exited with code $?"