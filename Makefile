APPS=cms

runserver:
	python manage.py runserver

test:
	python manage.py test $(APPS)

dbinitial:
	python manage.py syncdb --noinput --all
	python manage.py createsuperuser --user admin --email admin@admin.com
	python manage.py migrate --fake
	python manage.py cms check

update_deps:
	sudo pip install -r requirements.txt
