#!/bin/bash
start=$(date +%s)
CORES=$(expr $(nproc) + 1)
GLUON_VERSION=v2018.1.1
RELEASE=0.10.1
BRANCH=snapshot
#Build devices with the BROKEN flag? Use only for experimental-branch! [1/0]
BROKEN_DEVS=1

#git clone https://github.com/freifunk-gluon/gluon.git
#cd gluon && git clone https://github.com/h03e/site-ffoh.git && mv site-ffoh site
git fetch && git checkout $GLUON_VERSION && make update

for TARGET in ar71xx-generic ar71xx-tiny ar71xx-nand brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic ramips-mt7621 sunxi x86-generic x86-geode x86-64 ipq806x ramips-mt7620 ramips-mt7628 ramips-rt305x; do

echo "################# $(date) start building target $TARGET #################"
		        make -j$CORES GLUON_TARGET=$TARGET GLUON_RELEASE=$RELEASE GLUON_BRANCH=$BRANCH BROKEN=$BROKEN_DEVS || exit 1
		done
	#	make manifest GLUON_BRANCH=$BRANCH GLUON_RELEASE=$RELEASE
		echo "All listed Targets where build successfully."
		echo -n "Finished at: "; date
		echo "The job was done in $((($(date +%s)-start)/60)) minutes."

