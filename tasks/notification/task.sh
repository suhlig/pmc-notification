#!/bin/bash -ex

curl --user "api:${MAILGUN_API_KEY}"                            \
     --form from='Runtime PMC Notes <steffen.uhlig@de.ibm.com>' \
     --form to='Steffen Uhlig <steffen.uhlig@de.ibm.com>'       \
     --form subject="${SUBJECT}"                                \
     --form html="<${HTML_FILE}"                                \
  https://api.mailgun.net/v3/sandboxc604d410e1284695bb4948e088a20a13.mailgun.org/messages
