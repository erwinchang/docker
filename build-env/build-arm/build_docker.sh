#!/bin/sh

image_name=$(cat ./run.sh | grep IMAGE_NAME | sed 's/IMAGE_NAME=//g' | sed 's/"//g')

echo "sudo docker build -t $image_name ."
sudo docker build -t $image_name .
