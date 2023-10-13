#!/bin/bash
apt-get update
apt-get install -y openjdk-11-jre

apt-get update
apt-get install -y docker.io
apt-get update

systemctl enable docker
systemctl start docker
