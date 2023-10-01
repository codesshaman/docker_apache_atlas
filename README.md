# ApacheAtlas

## Installation:

``git clone https://gitlab.askona.ru/dp-data-platform/apacheatlas.git``

``cd apacheatlas`` - go to the project folder

``make env`` - create environment file

``make dirs`` - create all directories

``nano .env`` - change directories environment data

``make build`` - project build

## Взаимодействие:

Connect to your host in 21000 port. Login and password: admin/admin.

For the connection to shell inside of container use ``make connect``

Manual guide: ``make help``
