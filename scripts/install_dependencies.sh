#!/bin/bash

source /etc/profile.d/script.sh
sudo apt install -y python3-virtualenv
cd /home/ubuntu/todo-app
mkdir static/ && mkdir static/admin
sudo chown -R ubuntu:ubuntu static/
pip install --user --upgrade virtualenv
virtualenv -p python3 venv 
source venv/bin/activate
pip install -r requirements.txt
pip install gunicorn

aws --profile default configure set region "$AWS_REGION"

echo "This region is $AWS_REGION"
sudo cp /home/ubuntu/todo-app/templates/cloudwatch.conf /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
python3 manage.py collectstatic --noinput
echo "Migrating ..."
python3 manage.py migrate
echo "Migration completed."
echo "Creating superuser ...If not created"
echo "from users.models import User; User.objects.create_superuser('admin', 'admin@gmail.com', 'admin') if not User.objects.filter(username='admin').exists() else print('Superuser already exists.')" | python3 manage.py shell
echo "Done"
