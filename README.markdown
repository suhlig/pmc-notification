# PMC Notification

I wanted to get a nice-looking copy of the [CF Runtime PMC notes](https://github.com/cloudfoundry/pmc-notes) in my eMail inbox the day after the meeting took place.

Steps:

* The iCalendar resource publishes PMC meetings

  We can use the [CF Runtime PMC](https://www.google.com/calendar/ical/cloudfoundry.org_8ms13q67p9jjeeilng6dosnu50%40group.calendar.google.com/public/basic.ics) calendar; more info in the [wiki](https://github.com/cloudfoundry-community/cf-docs-contrib/wiki).

* When it triggers, we grab the latest file from the [CF Runtime PMC notes](https://github.com/cloudfoundry/pmc-notes) repository, render it to HTML and send it via email to me.

# Deployment

* Copy `sample-secrets.yml` to `secrets.yml` and fill in the values
* Add the pipeline to your Concourse

# Development

Some useful `fly` commands:

* `pmc-notes`

  ```bash
  fly --target=lite login --concourse-url=http://$(docker-machine ip):8080
  fly --target=lite set-pipeline --pipeline=pmc-notes --config=pipelines/pmc-notes.yml --load-vars-from=secrets.yml
  fly --target=lite unpause-pipeline --pipeline=pmc-notes
  fly --target=lite intercept -b 3
  ```

* `docker`

  ```bash
  fly --target=lite set-pipeline --pipeline=docker --config=pipelines/docker.yml --load-vars-from=secrets.yml
  fly --target=lite unpause-pipeline --pipeline=docker
  fly --target=lite trigger-job -j docker/"Create PMC Notes image"
  ```
