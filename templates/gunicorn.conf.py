bind = 'unix:/home/ubuntu/todo-app/todoApp.sock'

loglevel = 'info'
accesslog = '/home/ubuntu/logs/gunicorn_access.log'
errorlog = '/home/ubuntu/logs/gunicorn_error.log'

reload = False

user = 'ubuntu'
group = 'www-data'
