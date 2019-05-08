#!/bin/bash
echo "Installing oraclelinux-developer-release-el7 package" 
echo ""
yum install -y oraclelinux-developer-release-el7
if [ $? -eq 0 ]
then
   echo "running /usr/bin/ol_yum_configure.sh"
   /usr/bin/ol_yum_configure.sh
   echo "enabling  ol7_developer repo"
   yum -y install yum-utils
   yum-config-manager --enable  ol7_developer
   echo "installing HELM"
   yum -y install helm
   
fi
