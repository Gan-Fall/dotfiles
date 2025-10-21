#!/bin/bash

sudo sed -i.bak "s/ intel_iommu=on vfio-pci.ids=10de:2860,10de:22bd kvmfr.static_size_mb=128//g" /etc/default/grub
sudo sed -i.bak "s/ kvm_intel vfio vfio-pci//g" /etc/mkinitcpio.conf
sudo sed -i.bak "1s/\(.*\)/#\1/g" /etc/modprobe.d/kvmfr.conf
sudo sed -i.bak "2s/\(.*\)/#\1/g" /etc/modules-load.d/kvmfr.conf

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P

sudo systemctl disable virtqemud.service
sudo systemctl disable virtinterfaced.service
sudo systemctl disable virtnetworkd.service
sudo systemctl disable virtnodedevd.service
sudo systemctl disable virtnwfilterd.service
sudo systemctl disable virtsecretd.service
sudo systemctl disable virtstoraged.service
