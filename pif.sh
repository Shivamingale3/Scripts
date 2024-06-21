#!/bin/bash

git clone https://github.com/Evolution-XYZ/vendor_evolution-priv_keys-template ~/android/vendor/evolution-priv/keys

cd ~/android/vendor/evolution-priv/keys

./generate.sh
