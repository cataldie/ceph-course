#!/bin/bash

# to create a box vagrant [box-name] --base [vb-machine-name]

BOX=$1

if [ -z $BOX ]; then
    echo "Need argments."
    exit -1
fi

if [ ! -e $BOX ]; then
    echo "Not existed."
    exit -2
fi
 
mkdir -p /tmp/box
cp $BOX /tmp/box/$BOX

# Use the original box name as VM name.
# For example, your vagrant box is "myvm_xxxxxxxx", use "myvm"
VM="your_vm"

pushd /tmp/box

# extract box
tar xf $BOX

# import
vboxmanage import box.ovf

# Rename to a better name.
UUID=$(vboxmanage list vms | grep $VM | awk '{print $2;}')
vboxmanage modifyvm $UUID --name $VM

# p4p1 is your new network adapter name.
#vboxmanage modifyvm $VM --bridgeadapter2 p4p1
#popd

# remove temporary files
rm -rf /tmp/box

exit 0

