#!/bin/bash
src_dir=$( realpath "${BASH_SOURCE[0]}" | xargs -0 dirname )
function src_realpath() { (cd "$src_dir"; realpath "$1"); }
function src_source() { source "$(cd "$src_dir"; realpath "$1")"; }
function src_exec() { (cd "$src_dir"; $1) }
#-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# Arguments ---------------------------------------------------------
project_path=$(cd "$src_dir"; realpath "../..")
project_unity_version=$(cd "$project_path"; "./.scripts/lib/get-unity-editor-version.sh")

unity_path="/c/Program Files/Unity/Hub/Editor/$project_unity_version/Editor/Unity.exe"

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
