#!/bin/bash

# exit if a command fails
set -e

#
# Required parameters
if [ -z "${xcode_xcodeproj_file}" ] ; then
  echo " [!] Missing required input: xcode_xcodeproj_file"
  exit 1
fi
if [ ! -f "${xcode_xcodeproj_file}/project.pbxproj" ] ; then
  echo " [!] File project.pbxproj doesn't exist at specified path: ${xcode_xcodeproj_file}"
  exit 1
fi

if [ -z "${project_target}" ] ; then
  echo " [!] Missing required input: project_target"
  exit 1
fi

if [ -z "${code_sign_style}" ] ; then
  echo " [!] Missing required input: code_sign_style"
  exit 1
fi

if [ -z "${code_sign_identity}" ] ; then
  echo " [!] Missing required input: debug_code_sign_identity"
  exit 1
fi

if [ -z "${provisioning_profile_specifier}" ] ; then
  echo " [!] Missing required input: debug_provisioning_profile_specifier"
  exit 1
fi

if [ -z "${dry_run}" ] ; then
  echo " [!] Missing required input: dry_run"
  exit 1
fi

# ---------------------
# --- Configs:

echo " (i) Provided Project's .xcodeproj Path                : ${xcode_xcodeproj_file}"
echo " (i) Provided Project Target                           : ${project_target}"
echo " (i) Provided Code Sign Style                          : ${code_sign_style}"
echo
echo " (i) Provided Development Team (Debug)                 : ${development_team}"
echo " (i) Provided Code Sign Identity (Debug)               : ${code_sign_identity}"
echo " (i) Provided Provisioning Profile Specifier (Debug)   : ${provisioning_profile_specifier}"
echo
echo " (i) Dry-run preview                                   : ${dry_run}"



THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ruby $THIS_SCRIPT_DIR/edit.rb