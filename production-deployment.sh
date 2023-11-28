#!/bin/bash
set -x
cd ./simpleapp-manifests
git checkout master
git pull -f

# update replicas for production
sed -i '9,10s/0/1/g' ./overlays/dev/kustomization.yaml
# update replicas for canary
sed -i '11,12s/1/0/g' ./overlays/dev/kustomization.yaml
# Update weight=100  for production
sed -i '38,39s/80/100/g' ./overlays/dev/kustomization.yaml
# Update weight=0 for canary
sed -i '44,45s/20/0/g' ./overlays/dev/kustomization.yaml

git add .
git commit -m 'update production'
git push origin master 
