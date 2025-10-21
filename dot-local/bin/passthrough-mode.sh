#!/bin/bash

sudo sed -i.bak "s/^GRUB_CMDLINE_LINUX_DEFAULT='\(.*\)'/GRUB_CMDLINE_LINUX_DEFAULT='\1 intel_iommu=on vfio-pci.ids=10de:2860,10de:22bd kvmfr.static_size_mb=128'/1" /etc/default/grub
sudo sed -i.bak "s/^MODULES=(\(.*\))/MODULES=(\1 kvm_intel vfio vfio-pci)/1" /etc/mkinitcpio.conf
sudo sed -i.bak "1s/^#//1" /etc/modprobe.d/kvmfr.conf
sudo sed -i.bak "2s/^#//1" /etc/modules-load.d/kvmfr.conf

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P

sudo systemctl enable virtqemud.service
sudo systemctl enable virtinterfaced.service
sudo systemctl enable virtnetworkd.service
sudo systemctl enable virtnodedevd.service
sudo systemctl enable virtnwfilterd.service
sudo systemctl enable virtsecretd.service
sudo systemctl enable virtstoraged.service
