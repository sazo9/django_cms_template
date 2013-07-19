#!/bin/sh
PROJECT=$1
cd $2
django-admin.py startproject --template=https://github.com/felipecruz/loogica_project_template/archive/master.zip $PROJECT && cd $PROJECT
make dbinitial
make migrate
make runserver
