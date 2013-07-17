from django.conf.urls import patterns, include, url
from django.contrib.auth.views import login, logout

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    (r'^login/$', 'django.contrib.auth.views.login',
                   {'template_name': 'login.html'}),
    (r'^logout/$', 'django.contrib.auth.views.logout',
                   {'template_name': 'logged_out.html'}),
    url(r'^', include('cms.urls'))
)
