#!/usr/bin/env ruby

#
# If an event took place in the given calendar
#

require 'http'
require 'icalendar/recurrence'

def day(day)
  beginning = Time.utc(day.year, day.month, day.day,  0,  0,  0)
  ending    = Time.utc(day.year, day.month, day.day, 23, 59, 59)
  beginning..ending
end

def month(year, month)
  beginning = Time.utc(year, month,  1,  0,  0,  0)
  ending    = Time.utc(year, month, 31, 23, 59, 59)
  beginning..ending
end

def year(year)
  beginning = Time.utc(year,  1,  1,  0,  0,  0)
  ending    = Time.utc(year, 12, 31, 23, 59, 59)
  beginning..ending
end

def today
  day(Time.now.utc)
end

def yesterday
  day(Time.now.utc - 60 * 60 * 24)
end

def this_month
  now = Time.now.utc
  month(now.year, now.month)
end

def this_year
  year(Time.now.year)
end

response = HTTP.follow.get()

cals = Icalendar::Calendar.parse(response)

range = month(2017, 3)

cals.first.events.map do |event|
  event.occurrences_between(range.begin, range.end).map do |e|
    "#{event.summary}: #{e.start_time} - #{e.end_time}"
  end
end.flatten.compact.sort.each do |e|
  puts e
end
