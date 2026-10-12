#!/bin/env bash
md5sum build/**/*.{apk,ipa,aab} >build/RELEASE.md5sum
sha256sum build/**/*.{apk,ipa,aab} >build/RELEASE.sha256sum
sed -i 's|build/Spotube-.*-Bundle/||' build/RELEASE.sha256sum build/RELEASE.md5sum