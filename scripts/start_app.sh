#!/bin/bash

cd /home/ubuntu/todo-app
mkdir /home/ubuntu/logs
source venv/bin/activate
sudo supervisorctl start all