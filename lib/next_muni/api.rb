module NextMuni

  class Api
#  get stops
#  http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=sf-muni&r=45
#  get times
#  http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=<route tag>&d=<direction tag>&s=<stop tag>
#  multiples
#  http://webservices.nextbus.com/service/publicXMLFeed?command=predictionsForMultiStops&a=sf-muni&stops=45|45_IB2|6787&stops=45|45_IB2|6771
    def self.build_url(route_number, stop_id = nil, dir_id = nil)
      if stop_id.nil?
        url = "http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=sf-muni&r=#{route_number}"
      else
        url = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=#{route_number}&s=#{stop_id}"
        url += "&d=#{dir_id}" unless dir_id.nil?
      end
      url
    end
  end
end
