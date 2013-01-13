require 'badass_cinema'

require 'colored'

module BadassCinema
  module CLI
    @@commands = nil


    def self.start args
      return puts help if args.empty?

      command = args.shift
      
      unless commands.include? command
        puts "#{command} is not a valid command.".yellow
        puts "\n"
        puts help
        exit
      end

      require "badass_cinema/cli/command/#{command}"
      class_name = command.split("_").collect {|s| s.capitalize}.join
      class_object = eval("BadassCinema::CLI::Command::#{class_name}")
      command = class_object.new
      command.run(args)
    end

    def self.commands
      @@commands = @@commands || Dir[File.expand_path('../cli/command/*.rb', __FILE__)].reject {|path| path.include? 'base.rb'}.collect {|path| File.basename path, '.rb'}
    end

    private
    def self.help
      <<-EOT
## Usage
badass-cinema COMMAND [args]

### Commands
For help about a specific command, run badass-cinema COMMAND.

Commands are:
 #{commands.join "\n"}
EOT
    end
  end
end