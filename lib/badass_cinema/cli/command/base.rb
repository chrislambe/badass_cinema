require 'ostruct'
require 'optparse'

module BadassCinema::CLI::Command
  class Base
    def help
      @option_parser
    end

    def initialize
      @options = OpenStruct.new
      @option_parser = OptionParser.new
    end

    def run args = nil
      @option_parser.parse args

      if args.nil? || args.empty?
        puts help
        exit
      end
    end
  end
end