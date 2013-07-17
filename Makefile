APPS=cms

runserver:
	python manage.py runserver

test:
	python manage.py test $(APPS)

dbreset:
	dropdb $PROJECT && createdb $PROJECT && rm -rf $APP/migrations

dbinitial:
	python manage.py schemamigration --initial $(APPS) && python manage.py syncdb --noinput && python manage.py createsuperuser --user admin --email admin@admin.com

server_dbinitial:
	python manage.py syncdb --noinput && python manage.py createsuperuser --user admin --email admin@admin.com

schemamigration:
	python manage.py schemamigration --auto $(APPS)

migrate:
	python manage.py migrate $(APPS)

migrate_no_input:
	python manage.py migrate --noinput $(APPS)

update_deps:
	sudo pip install -r requirements.txt
