#!/usr/bin/env bash

# Attempt to run as user
ls -l /workspace
ls -l /builder
ls -l /builder/home

sudo chown -R $USER /workspace
sudo chown -R $USER /builder/home