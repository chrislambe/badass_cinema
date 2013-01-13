module BadassCinema
  CINEMAS = {
    ritz: {id:'0002', name:'Ritz'},
    village: {id:'0003', name:'Village'},
    south_lamar: {id:'0004', name:'South Lamar'},
    lake_creek: {id:'0005', name:'Lake Creek'},
    slaughter_lane: {id:'0006', name:'Slaughter Lane'},
    rolling_roadshow: {id:'0090', name:'Rolling Roadshow'}
  }

  module InitializeWithHash
    module ClassMethods
      
    end
    
    module InstanceMethods
      def initialize args
        if args.is_a? Hash
          args.each do |k,v|
            instance_variable_set("@#{k}", v) if self.class.method_defined?(k)
          end
        end
      end
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end

require "badass_cinema/version"