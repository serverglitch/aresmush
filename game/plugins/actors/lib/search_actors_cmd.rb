module AresMUSH

  module Actors
    class ActorsSearchCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandRequiresArgs
      
      attr_accessor :name
      
      def initialize
        self.required_args = ['name']
        self.help_topic = 'actors'
        super
      end

      def crack!
        self.name = trim_input(cmd.args)
      end
      
      def handle
        list = ActorRegistry.all.select { |a| is_match?(a) }
        list = list.sort { |a,b| a.charname <=> b.charname }
        paginator = Paginator.paginate(list, 1, 100)
        
        template = ActorsListTemplate.new(paginator, client) 
        template.render
      end
      
      def is_match?(actor)
        return true if actor.charname.upcase == self.name.upcase
        return actor.actor.upcase =~ /#{self.name.upcase}/
      end
        
    end
  end
end
