#!/bin/bash

cd frameworks/av

git remote add other https://github.com/raghavt20/frameworks_av.git

git fetch other

git cherry-pick 264b783
