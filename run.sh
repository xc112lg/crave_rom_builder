#!/bin/bash
export GH_TOKEN=$(cat gh_token.txt)
gh auth login --with-token $GH_TOKEN
gh auth status
mkdir -p LineageOS21
bp=$(cat bp.txt)
cp -f crave_rom_builder/run1.sh run1.sh
chmod +x run1.sh
cp -f crave_rom_builder/craverun.sh LineageOS21
tmux set-environment bp "$bp"
tmux kill-session -t $bp
tmux new-session -d -s $bp
tmux list-session -t $bp
tmux send-keys -t $bp C-a C-k ./run1.sh C-m
