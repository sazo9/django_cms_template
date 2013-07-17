APPS=$APP

venv_boot:
	mkvirtualenv --distribute --python=/usr/local/bin/python -r requirements.txt $PROJECT

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

coverage:
	coverage run --source="$(shell pwd)" manage.py test $(APPS)
	coverage html --include="$(shell pwd)*" --omit="admin.py,manage.py,fabfile.py"

clean:
	rm -rf htmlcov

# Tasks with parameters
# make add_app app_name -> create an new app with app_name

ifneq ($(filter$(MAKECMDGOALS),with_args), "")
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

with_args=new_app,app_schemamigration

new_app:
	django-admin.py startapp --template=https://github.com/loogica/loogica_app_template/archive/master.zip $(RUN_ARGS)
	@echo Add this App to your settings INSTALLED_APPS and then run 'make app_schemamigration $(RUN_ARGS)'

app_schemamigration:
	python manage.py schemamigration --initial $(RUN_ARGS)
	python manage.py migrate $(RUN_ARGS)
