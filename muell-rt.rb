require 'icalendar'


inputs = {"../muell_gelb"=>"Gelber Sack","../muell_bio"=>"Biomüll","../muell_pap"=>"Papier","../muell_rest"=>"Restmüll"}

class DateListSlurper
  DateFormat = "%d.%m.%y"
  attr_accessor :input
  attr_accessor :calendar
  attr_accessor :type

  def process
    File.readlines(@input).each {|line| consumeSingleDate line}
  end

  def consumeSingleDate(rawText)
    abholung=Date.strptime(rawText, DateFormat)

    @calendar.event do |e|
      e.dtstart     = Icalendar::Values::Date.new(abholung)
      e.dtend       = Icalendar::Values::Date.new(abholung)
      e.summary     = @type
    end
  end
end


cal = Icalendar::Calendar.new
inputs.each_key do |file|
  slurper = DateListSlurper.new
  slurper.input = file
  slurper.type = inputs[file]
  slurper.calendar = cal
  slurper.process
end

cal.publish
puts cal.to_ical
