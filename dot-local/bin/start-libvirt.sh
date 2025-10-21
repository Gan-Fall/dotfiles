#!/bin/bash

sudo systemctl start virtqemud.service
sudo systemctl start virtinterfaced.service
sudo systemctl start virtnetworkd.service
sudo systemctl start virtnodedevd.service
sudo systemctl start virtnwfilterd.service
sudo systemctl start virtsecretd.service
sudo systemctl start virtstoraged.service
