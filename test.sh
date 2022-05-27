#! /bin/bash

val_acc=$(sudo -S docker container exec model  jq .validation_acc /home/jovyan/results/train_metadata.json)
threshold=0.8

if echo "$threshold > $val_acc" | bc -l | grep -q 1
then
	echo 'validation accuracy is lower than the threshold, process stopped'
else
   echo 'validation accuracy is higher than the threshold'
   sudo -S docker container exec model python3 test.py
   sudo -S docker container exec model cat /home/jovyan/results/train_metadata.json /home/jovyan/results/test_metadata.json 
fi
