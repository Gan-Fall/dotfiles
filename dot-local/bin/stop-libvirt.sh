#!/bin/bash

sudo systemctl stop virtqemud.service
sudo systemctl stop virtinterfaced.service
sudo systemctl stop virtnetworkd.service
sudo systemctl stop virtnodedevd.service
sudo systemctl stop virtnwfilterd.service
sudo systemctl stop virtsecretd.service
sudo systemctl stop virtstoraged.service
