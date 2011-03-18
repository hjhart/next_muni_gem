require 'rubygems'

require 'rexml/document'
require 'net/http'

require 'next_muni/api'

module NextMuni
  def self.get_stops(route)
    url = NextMuni::Api.build_url(route.upcase)
    xml = Net::HTTP.get(URI.parse(url))
    doc = REXML::Document.new(xml)
    directions = []
    stops = {}

    doc.elements.each('body/route/stop') do |ele|
      stops[ele.attributes['tag']] = ele.attributes['title']
    end

    doc.elements.each('body/route/direction') do |direction|
      direction_stops = {}
      direction.elements.each('stop') do |stop|
        direction_stops[stop.attributes['tag']] = stops[stop.attributes['tag']]
      end

      directions << {
          :id => direction.attributes['tag'],
          :name => direction.attributes['title'],
          :stops => direction_stops
      }
    end
    directions
  end

  def self.get_times(route_no, stop_no, direction_id=nil)
    url = NextMuni::Api.build_url(route_no.upcase, stop_no, direction_id)
    xml = Net::HTTP.get(URI.parse(url))

    doc = REXML::Document.new(xml)
    times = []
    doc.elements.each('body/predictions/direction/prediction') do |time|
      times << time.attributes['minutes']
    end
    times
  end
end