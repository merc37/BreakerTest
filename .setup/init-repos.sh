#!/bin/bash
echo "Make sure you are running this script from the folder that contains your new Unity project folder!"
echo
read -r -p "Press Enter to acknowledge this..."
echo

# Get user inputs
echo "Enter the name of the new Unity Project (Same name as its folder)."
echo "Ex. SpikeOutRevenge"
echo
read -r -p "New Project Name: " NewProjName
echo
echo "Enter the Github username of the user that will own the forked clones of base repos. (Probably your Github username)"
echo "Ex. githubUser22"
echo
read -r -p "Github Username: " OwnerGitHubUserName
echo
echo "Enter the directory where you would like to clone the Unversioned repo."
echo "NOTE: You probably want this at the root of some drive to avoid windows path character limit!"
echo "Ex. E:\\"
echo
read -r -p "Target Dir for Unversioned: " UnversionedTargetDir
echo

# Accept Inputs
echo "Your selections:"
echo "NewProjName = $NewProjName"
echo "OwnerGitHubUserName = $OwnerGitHubUserName"
echo "UnversionedTargetDir = $UnversionedTargetDir"
echo 
read -r -p "Does this look correct? (Y/N) " IsCorrect

# Exit if user does not accept
if [ "$IsCorrect" != "y" ] && [ "$IsCorrect" != "Y" ]; then
  echo "Terminating...Press Enter to close"
  read
  exit 1
fi

echo "You accepted the selections"


#Create new Main repo fork and combine with existing Unity project folder
read -p "mkdir temp"
mkdir temp
read -p "cd temp"
cd temp
read -p "git init -b main"
git init -b main
read -p "hub create $OwnerGitHubUserName/$NewProjName"
hub create $OwnerGitHubUserName/$NewProjName
read -p "git remote rm origin"
git remote rm origin
read -p "git remote add origin https://github.com/djc5627/$NewProjName.gi"t
git remote add origin https://github.com/djc5627/$NewProjName.git
read -p "git config --local merge.ff only"
git config --local merge.ff only
read -p "git config --local submodule.recurse true"
git config --local submodule.recurse true
read -p "cd .."
cd ..
read -p "mv temp/.git $NewProjName/.git"
mv temp/.git $NewProjName/.git
read -p "rm -rf temp"
rm -rf temp
read -p "cd $NewProjName"
cd $NewProjName


# Pull from Main template into fork and push to new repo
read -p "cwd=$(pwd)"
cwd=$(pwd) # Store current dir in variable
read -p "git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate.git"
git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate.git
read -p "git config --local submodule.recurse false"
git config --local submodule.recurse false
read -p "git pull --rebase upstream main"
git pull --rebase upstream main
read -p "git config --local submodule.recurse true"
git config --local submodule.recurse true
read -p "git remote rm upstream"
git remote rm upstream
read -p "git add ."
git add .
#Should have the .gitignore at this point
read -p "git commit -m "Initial Commit""
git commit -m "Initial Commit"
read -p "git push --set-upstream origin main"
git push --set-upstream origin main

# Create new PrivateAssets repo fork inside Assets folder
read -p "cd Assets"
cd Assets
read -p "mkdir $NewProjName-PrivateAssets"
mkdir $NewProjName-PrivateAssets
read -p "cd $NewProjName-PrivateAssets"
cd $NewProjName-PrivateAssets
read -p "git init -b main"
git init -b main
read -p "hub create -p $OwnerGitHubUserName/$NewProjName-PrivateAssets"
hub create -p $OwnerGitHubUserName/$NewProjName-PrivateAssets
read -p "git remote rm origin"
git remote rm origin
read -p "git remote add origin https://github.com/djc5627/$NewProjName-PrivateAssets.git"
git remote add origin https://github.com/djc5627/$NewProjName-PrivateAssets.git
read -p "git config --local merge.ff only"
git config --local merge.ff only

# Pull from PrivateAssets template into fork and push to new repo
read -p "git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate-PrivateAssets.git"
git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate-PrivateAssets.git
read -p "git config --local submodule.recurse false"
git config --local submodule.recurse false
read -p "git pull --rebase upstream main"
git pull --rebase upstream main
read -p "git config --local submodule.recurse true"
git config --local submodule.recurse true
read -p "git remote rm upstream"
git remote rm upstream
read -p "git add ."
git add .
read -p "git commit -m "Initial Commit""
git commit -m "Initial Commit"
read -p "git push --set-upstream origin main"
git push --set-upstream origin main

# Add PrivateAssets as a submodule to Main
read -p "cd ../.."
cd ../..
read -p "git submodule add https://github.com/$OwnerGitHubUserName/$NewProjName.git Assets/$NewProjName-PrivateAssets"
git submodule add https://github.com/$OwnerGitHubUserName/$NewProjName.git Assets/$NewProjName-PrivateAssets

# Push addition of submodule to main repo
read -p "git add ."
git add .
read -p "git commit -m "Add PrivateAssets submodule""
git commit -m "Add PrivateAssets submodule"
read -p "git push"
git push

#  Create new Unversioned repo fork in UnversionedTargetDir
read -p "cd Assets"
cd Assets
read -p "mkdir $UnversionedTargetDir/$NewProjName-Unversioned"
mkdir $UnversionedTargetDir/$NewProjName-Unversioned
read -p "cd $UnversionedTargetDir/$NewProjName-Unversioned"
cd $UnversionedTargetDir/$NewProjName-Unversioned
read -p "git init -b main"
git init -b main
read -p "hub create -p $OwnerGitHubUserName/$NewProjName-Unversioned"
hub create -p $OwnerGitHubUserName/$NewProjName-Unversioned
read -p "git remote rm origin"
git remote rm origin
read -p "git remote add origin https://github.com/djc5627/$NewProjName-Unversioned.git"
git remote add origin https://github.com/djc5627/$NewProjName-Unversioned.git

# Pull from Unversioned template into fork and push to new repo
read -p "git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate-Unversioned"
git remote add upstream https://github.com/bowlmonkeylabs/UnityTemplate-Unversioned
read -p "git config --local submodule.recurse false"
git config --local submodule.recurse false
read -p "git pull --rebase upstream main"
git pull --rebase upstream main
read -p "git config --local submodule.recurse true"
git config --local submodule.recurse true
read -p "git remote rm upstream"
git remote rm upstream
read -p "git push --set-upstream origin main"
git push --set-upstream origin main

# Run script to init the Annex
read -p "./INIT-ANNEX.sh $NewProjName"
./INIT-ANNEX.sh $NewProjName

# Init the annex
# read -p "git annex init "$AnnexRemoteName" "
# git annex init "$AnnexRemoteName" 
# read -p "git annex enableremote cloud"
# git annex enableremote cloud

# Make symLink in Assets folder pointing to this forked repo
read -p "cd $cwd"
cd "$cwd"
read -p "./.setup/CreateSymLink.sh "Assets\Unversioned" "$UnversionedTargetDir/$NewProjName-Unversioned""
./.setup/create-sym-link.sh "Assets\Unversioned" "$UnversionedTargetDir/$NewProjName-Unversioned"

#Init Package Manager Assets
read -p "python .setup/InitPackageManager.py"
python .setup/InitPackageManager.py

# Delete .setup
read -p "rm -r .setup"
rm -r .setup

# Exit Script
echo "Press Enter to exit..."
read
exit 0
