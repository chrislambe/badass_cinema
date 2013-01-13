require 'json'
require 'net/http'

require 'chronic'

require 'badass_cinema/model/film'
require 'badass_cinema/model/session'

module BadassCinema
  class Calendar
    ENDPOINT = "http://tix4.drafthouse.com/adcWSVistaITJson/CinemaCalendar.aspx"
    CALLBACK = "tix.calendarLinks"

    attr_reader :films,:sessions

    def films
      load if @films.nil?
      @films
    end

    def sessions args = nil
      load if @sessions.nil?

      return @sessions unless args.is_a? Hash

      title = args[:title]
      date_string = args[:date_string]

      @sessions.select do |session|
        title_match = true
        date_match = true

        unless title.nil?
          title = Regexp.new(title,Regexp::IGNORECASE) unless title.is_a?(Regexp)
          
          title_match = !(session.film.title =~ title).nil?
        end

        unless date_string.nil?
          time = Chronic.parse date_string
          raise(ArgumentError, "\"#{date_string}\" is not a valid date string.") if time.nil?

          date_match = session.date == time.to_date
        end

        # puts "Title matches: #{title_match}, date matches: #{date_match}"
        title_match && date_match
      end
    end

    def data
      load if @data.nil?
      @data
    end

    def initialize cinema
      @cinema = cinema
    end

    def load
      cinema_data = BadassCinema::CINEMAS[@cinema]
      params = {
        cinemaid:cinema_data[:id],
        callback:CALLBACK
      }
      query = params.collect {|k,v| "#{k}=#{v}"}.join("&")
      uri = URI.parse "#{ENDPOINT}?#{query}"
      response = Net::HTTP.get_response uri
      match = /^.+?\((.+)\)/.match response.body
      @data = JSON.parse match[1]
      
      @sessions = Array.new
      @films = Array.new

      if @data.has_key? 'Cinema'
        @data['Cinema']['Months'].each do |month_data|
          month_name,year = month_data['Month'].split(" ")
          month_data['Weeks'].each do |week_data|
            week_data['Days'].each do |day_data|
              next unless day_data.has_key? 'Films'
              day = day_data['Day']
              day_data['Films'].each do |film_data|
                film = BadassCinema::Model::Film.new id:film_data['FilmId'],
                                                     title:film_data['Film'],
                                                     type:film_data['FilmType'],
                                                     series_id:film_data['SeriesId'],
                                                     is_rss:film_data['IsRSS']
                @films << film
                film_data['Sessions'].each do |session_data|
                  session = BadassCinema::Model::Session.new id:session_data['SessionId'],
                                                             time:session_data['SessionTime'],
                                                             date:Chronic.parse("#{month_name} #{day}, #{year}").to_date,
                                                             status:session_data['SessionStatus'],
                                                             sales_url:session_data['SessionSalesURL']
                  film.add_session session
                  @sessions << session
                end
              end
            end
          end
        end
      end
    end
  end
end