require 'badass_cinema/calendar'
require 'badass_cinema/cli/command/base'

module BadassCinema::CLI::Command
  class Calendar < BadassCinema::CLI::Command::Base

    def initialize
      super
      @option_parser.banner = <<-EOT
## Usage
badass-cinema calendar [args]

## Valid cinema names:
#{BadassCinema::CINEMAS.collect {|k,v| " #{k}"}.join("\n")}

## Options
EOT
      @option_parser.on '-c', '--cinema [cinema]', 'Filter by a particular cinema (see above for valid names)' do |cinema_name|
        @options.cinema_name = cinema_name
      end
      
      @option_parser.on '-d', '--date [date]', 'Filter by a particular date (accepts most anything you can throw at it)' do |date_string|
        @options.date_string = date_string
      end
      
      @option_parser.on '-t', '--title [title]', 'Filter by a title (accepts partial titles as well)' do |title|
        @options.title = title
      end

      @option_parser.on '-w', '--[no-]watch', 'Monitor your query' do |watch|
        @options.watch = watch
      end
    end

    def run args = nil
      super

      puts render_calendar cinema: @options.cinema_name, 
                           date_string: @options.date_string, 
                           title: @options.title
    end

    private
    def render_calendar args = nil
      title = args[:title]
      date_string = args[:date_string]

      if args[:cinema].nil?
        cinemas = BadassCinema::CINEMAS.collect {|k,v| k}
      else
        cinemas = [args[:cinema].to_sym]
      end


      output = String.new
      cinemas.each do |cinema|
        cinema_data = BadassCinema::CINEMAS[cinema]
        calendar = BadassCinema::Calendar.new cinema

        output += "\n#{cinema_data[:name]}\n"
        cinema_data[:name].length.times {output += '-'}
        output += "\n"
        sessions = calendar.sessions title:title, date_string:date_string
        output += "No films found at #{cinema_data[:name]}.\n".yellow if sessions.length == 0
        
        schedule = Hash.new
        sessions.each do |session|
          session_date = session.date.to_s
          session_title = session.film.title
          schedule[session_date] = Hash.new unless schedule.has_key? session_date
          schedule[session_date][session_title] = Array.new unless schedule[session_date].has_key? session_title
          schedule[session_date][session_title] << session
        end

        schedule.each do |date,films|
          output += Date.parse(date).strftime('%B %d, %Y') + "\n"
          films.each do |film_title,film_sessions|
            output += "\t#{film_title}\n"
            film_sessions.each do |film_session|
              case film_session.status
              when 'onsale'
                status = "On sale".green
              when 'notonsale'
                status = "Not on sale".yellow
              when 'soldout'
                status = "Sold out".red
              when 'past'
                status = "Past".red
              else
                status = film_session.status.red
              end
              output += "\t\t#{film_session.time}: #{status}\n"
            end
          end
        end
      end

      return output
    end
  end
end