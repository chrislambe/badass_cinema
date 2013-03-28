# Badass Cinema
Badass Cinema is a library (and CLI tool!) for accessing data from the Alamo Drafthouse cinema. Currently supports the Austin, TX theaters.

## Usage

### Calendar
    require 'badass_cinema/calendar'
    
    # Instantiate a calendar with a cinema symbol (serves as a key for BadassCinema::CINEMAS hash)
    ritz_calendar = BadassCinema::Calendar.new :ritz
    
    # Returns an array of BadassCinema::Model::Session objects, each represents a show for a particular film
    ritz_calendar.sessions
    
    # Returns an array of BadassCinema::Model::Film objects, each representing a particular film
    ritz_calendar.films
    
    # The BadassCinema::Calendar#sessions function optionally accepts a filter hash
    ritz_calendar.sessions title: "Terminator 2", date_string: "july 25, 2004"
    
    # The title option also accepts a Regexp object
    ritz_calendar.sessions title: /terminator [12]/i

## CLI
This library comes with a command line tool, used as follows:

`badass-cinema COMMAND [args]`

### Commands
#### calendar
The calendar command is for accessing calendar data. Surprised?

`badass-cinema calendar [args]`

##### Options
    -c, --cinema [cinema]            Filter by a particular cinema (see above for valid names)
    -d, --date [date]                Filter by a particular date (accepts most anything you can throw at it)
    -t, --title [title]              Filter by a title (accepts partial titles as well)

##### Cinema
Any of the following values are valid:

* `ritz`
* `village`
* `south_lamar`
* `lake_creek`
* `slaughter_lane`
* `rolling_roadshow`

##### Date
The library will accept pretty much any semantic date. Dates are parsed with the delightful [Chronic][chronic] gem. For example:

* `tomorrow`
* `friday`
* `"january 11th"`

##### Title
Filter the results by title. Gets converted to a regex for the time being, until someone points out why that's a really terrible idea.

## The Future
Right now this library only returns data about the Drafthouse calendar. That fulfills the need that pushed me to create this gem. If you'd like to see other Alamo Drafthouse data sources made available through this library, let me know!

## License
The Badass Cinema library is released under the [MIT License][mit-license]

[chronic]: https://github.com/mojombo/chronic
[mit-license]: http://www.opensource.org/licenses/MIT