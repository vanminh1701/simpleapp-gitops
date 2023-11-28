#!/bin/bash
set -x
cd ./simpleapp-manifests
git checkout master
git pull -f

# update replicas for canary
sed -i '11,12s/0/1/g' ./overlays/dev/kustomization.yaml
# Update weight=100  for production
sed -i '38,39s/100/80/g' ./overlays/dev/kustomization.yaml
# Update weight=0 for canary
sed -i '44,45s/ 0/ 20/g' ./overlays/dev/kustomization.yaml

git add .
git commit -m 'update canary'
git push origin master
