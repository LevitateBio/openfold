#!/usr/bin/env bash

echo "checking out main branch"
git checkout main
echo "pulling latest changes"
git pull

VERSION=`cat VERSION`
ALPHAFOLD_VERSION=`cat alphafold/version.py | grep version | grep -o "\d*\.\d*\.\d*"`
CUDA_VERSION=`cat docker/Dockerfile | grep CUDA | ggrep -oP '(?<=CUDA=)\d*(\.\d+)*'`
OS_VERSION=`cat docker/Dockerfile | grep nvidia/cuda | ggrep -oP 'ubuntu\K[0-9]+\.[0-9]+' | sed 's/^/Ubuntu /'`

echo "current git HEAD is \"$(git log --oneline |head -1)\""
read -p "Would you like to create and push the tag $VERSION at the current head of the master branch? (y/n)" proceed

if [[ ${proceed} == "y" ]]; then
    git tag "$VERSION" -m "AF2 – Levitate Bio

    AlphaFold2: v$ALPHAFOLD_VERSION
    CUDA Toolkit: v$CUDA_VERSION
    OS: $OS_VERSION"

    git push --tags
fi