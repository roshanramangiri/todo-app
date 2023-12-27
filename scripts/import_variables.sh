#!/bin/bash

source /etc/profile.d/script.sh
cd /home/ubuntu/todo-app
aws --profile default configure set region "$AWS_REGION"
#load env
cp env-sample .env
DATABASE_HOST=$(aws ssm get-parameter --name "$PROJECT_NAME"_database_host --region $AWS_REGION --with-decryption --query "Parameter.Value" --output text ) 
sed -i '/^DATABASE_HOST/d' /home/ubuntu/todo-app/.env
echo "DATABASE_HOST = $DATABASE_HOST" >> /home/ubuntu/todo-app/.env

DATABASE_PASSWORD=$(aws ssm get-parameter --name "$PROJECT_NAME"_database_password --region $AWS_REGION --with-decryption --query "Parameter.Value" --output text ) 
sed -i '/^DATABASE_PASSWORD/d' /home/ubuntu/todo-app/.env
echo "DATABASE_PASSWORD = $DATABASE_PASSWORD" >> /home/ubuntu/todo-app/.env

DATABASE_USER=$(aws ssm get-parameter --name "$PROJECT_NAME"_database_user --region $AWS_REGION --with-decryption --query "Parameter.Value" --output text ) 
sed -i '/^DATABASE_USER/d' /home/ubuntu/todo-app/.env
echo "DATABASE_USER = $DATABASE_USER" >> /home/ubuntu/todo-app/.env

DATABASE_NAME=$(aws ssm get-parameter --name "$PROJECT_NAME"_database_name --region $AWS_REGION --with-decryption --query "Parameter.Value" --output text ) 
sed -i '/^DATABASE_NAME/d' /home/ubuntu/todo-app/.env
echo "DATABASE_NAME = $DATABASE_NAME" >> /home/ubuntu/todo-app/.env

sed -i '/^AWS_REGION/d' /home/ubuntu/todo-app/.env
echo "AWS_REGION = $AWS_REGION" >> /home/ubuntu/todo-app/.env

sudo mkdir /home/ubuntu/logs
cd /home/ubuntu/logs
sudo touch djangoapp.log gunicorn_access.log gunicorn_error.log nginx_access.log nginx_error.log
sudo chmod 777 djangoapp.log gunicorn_access.log gunicorn_error.log nginx_access.log nginx_error.log