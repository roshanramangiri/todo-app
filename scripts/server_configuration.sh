#!/bin/bash

source /etc/profile.d/script.sh
aws --profile default configure set region "$AWS_REGION" 
cd /home/ubuntu/todo-app
source venv/bin/activate

sudo cp /home/ubuntu/todo-app/templates/nginx.conf /etc/nginx/sites-available/todo-app
sudo ln -s /etc/nginx/sites-available/todo-app /etc/nginx/sites-enabled/todo-app
sudo rm /etc/nginx/sites-enabled/default
sudo chmod 755 /home/ubuntu
sudo service nginx restart

sudo cp /home/ubuntu/todo-app/templates/gunicorn.conf.py /home/ubuntu/todo-app/gunicorn.conf.py
sudo cp /home/ubuntu/todo-app/templates/supervisor.conf /etc/supervisor/conf.d/todo-app.gunicorn.conf

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all
echo "Superviosr configured"