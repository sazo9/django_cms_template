APPS={{ app_name }}

bootstrap:
	mkvirtualenv --distribute --python=/usr/local/bin/python -r requirements.txt {{ project_name }}
	
runserver:
	python manage.py runserver

test:
	python manage.py test $(APPS)

dbreset:
	dropdb {{ project_name }} && createdb {{ project_name }} && rm -rf {{ app_name }}/migrations 

dbinitial:
	python manage.py schemamigration --initial $(APPS) && python manage.py syncdb --noinput && python manage.py createsuperuser --user admin --email admin@admin.com

server_dbinitial:
	python manage.py syncdb --noinput && python manage.py createsuperuser --user admin --email admin@admin.com

migrate:
	python manage.py migrate $(APPS)

migrate_no_input:
	python manage.py migrate --noinput $(APPS)

update_deps:
	sudo pip install -r requirements.txt

coverage:
	coverage run --source="$(shell pwd)" manage.py test $(APPS)
	coverage html --include="$(shell pwd)*" --omit="admin.py,manage.py"

clean:
	rm -rf htmlcov
