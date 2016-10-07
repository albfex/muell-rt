require 'icalendar'

input = "muell_gelb"
cal = Icalendar::Calendar.new

File.readlines(input).each do |datum|
  abholung=Date.strptime(datum, "%d.%m.%y")

  cal.event do |e|
    e.dtstart     = Icalendar::Values::Date.new(abholung)
    e.dtend       = Icalendar::Values::Date.new(abholung)
    e.summary     = "Gelber Sack"
  end


  cal.publish
end
puts cal.to_ical
