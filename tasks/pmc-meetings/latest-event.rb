#!/usr/bin/env ruby

require 'http'
require 'icalendar/recurrence'

response = HTTP
  .follow
  .get('https://www.google.com/calendar/ical/cloudfoundry.org_8ms13q67p9jjeeilng6dosnu50@group.calendar.google.com/public/basic.ics')

cals = Icalendar::Calendar.parse(response)

# materialize recurrences in this year
cals.first.events.map do |event|
  event.occurrences_between(Time.parse("2017-01-01"), Time.parse("2017-12-31")).map do |e|

    # yesterday?
    if 5 == e.start_time.month && 3 == e.start_time.day
      "#{event.summary}: #{e.start_time} - #{e.end_time}"
    end
  end
end.flatten.compact.sort.each do |e|
  puts e
end
