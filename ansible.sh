#!/bin/bash
apt-get update
apt-get upgrade -y

sudo apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible 
