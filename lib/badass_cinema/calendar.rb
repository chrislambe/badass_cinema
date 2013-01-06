require 'json'
require 'net/http'

module BadassCinema
  class Calendar
    ENDPOINT = "http://tix4.drafthouse.com/adcWSVistaITJson/CinemaCalendar.aspx"
    CALLBACK = "tix.calendarLinks"

    @cinema = nil
    @data = nil

    attr_reader :data

    def initialize cinema
      @cinema = cinema
      load
    end

    def load
      cinema_data = BadassCinema::CINEMAS[@cinema]
      params = {
        cinemaid:cinema_data[:id],
        callback:CALLBACK
      }
      query = params.collect {|k,v| "#{k}=#{v}"}.join("&")
      uri = URI.parse("#{ENDPOINT}?#{query}")
      response = Net::HTTP.get_response uri
      match = /^.+?\((.+)\)/.match response.body
      data = match[1]

      @data = JSON.parse data
    end
  end
end