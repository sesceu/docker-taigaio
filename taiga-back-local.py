from .common import *

MEDIA_URL = "##TAIGA_PROTOCOL##://##TAIGA_DOMAIN##/media/"
STATIC_URL = "##TAIGA_PROTOCOL##://##TAIGA_DOMAIN##/static/"
ADMIN_MEDIA_PREFIX = "##TAIGA_PROTOCOL##://##TAIGA_DOMAIN##/static/admin/"
SITES["front"]["scheme"] = "##TAIGA_PROTOCOL##"
SITES["front"]["domain"] = "##TAIGA_DOMAIN##"

#SECRET_KEY = "dontknowwhatthisisusedfor"

DEBUG = False
TEMPLATE_DEBUG = False
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "##TAIGA_SMTP_FROM##"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

# Uncomment and populate with proper connection parameters
# for enable email sending. EMAIL_HOST_USER should end by @domain.tld
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
EMAIL_USE_TLS = ##TAIGA_SMTP_TLS##
EMAIL_HOST = "##TAIGA_SMTP_HOST##"
EMAIL_HOST_USER = "##TAIGA_SMTP_USER##"
EMAIL_HOST_PASSWORD = "##TAIGA_SMTP_PASSWORD"
EMAIL_PORT = ##TAIGA_SMTP_PORT##

# Uncomment and populate with proper connection parameters
# for enable github login/singin.
#GITHUB_API_CLIENT_ID = "yourgithubclientid"
#GITHUB_API_CLIENT_SECRET = "yourgithubclientsecret"
