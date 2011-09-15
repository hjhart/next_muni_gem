require 'rubygems'

require 'rexml/document'
require 'net/http'


module NextMuni
  def self.get_stops(route)
    url = NextMuni.build_url(route.upcase)
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
    url = NextMuni.build_url(route_no.upcase, stop_no, direction_id)
    xml = Net::HTTP.get(URI.parse(url))

    doc = REXML::Document.new(xml)
    times = []
    doc.elements.each('body/predictions/direction/prediction') do |time|
      times << time.attributes['minutes']
    end
    times
  end

  # Some agencies: sf-muni, actransit
  def self.get_routes(agency)
    url = "http://webservices.nextbus.com/service/publicXMLFeed?command=routeList&a=#{agency}"
    xml = Net::HTTP.get(URI.parse(url))

    doc = REXML::Document.new(xml)
    routes = []

    doc.elements.each('body/route') do |route|
      routes << {
          :id => route.attributes['tag'],
          :title => route.attributes['title']
      }
    end
    routes
  end

#  get stops
#  http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=sf-muni&r=45
#  get times
#  http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=<route tag>&d=<direction tag>&s=<stop tag>
#  multiples
#  http://webservices.nextbus.com/service/publicXMLFeed?command=predictionsForMultiStops&a=sf-muni&stops=45|45_IB2|6787&stops=45|45_IB2|6771
  def self.build_url(route_number, agency='sf-muni', stop_id = nil, dir_id = nil)
    if stop_id.nil?
      url = "http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=#{agency}&r=#{route_number}"
    else
      url = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=#{agency}&r=#{route_number}&s=#{stop_id}"
      url += "&d=#{dir_id}" unless dir_id.nil?
    end
    url
  end

end