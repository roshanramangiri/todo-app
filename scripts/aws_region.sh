#!/bin/bash

source /etc/profile.d/script.sh
aws --profile default configure set region "$AWS_REGION"