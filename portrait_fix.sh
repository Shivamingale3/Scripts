#!/bin/bash

cd frameworks/av

git remote add other https://github.com/raghavt20/frameworks_av.git

git fetch other

git cherry-pick 7403257408790628a71e4c3acaf0620b7360096e
