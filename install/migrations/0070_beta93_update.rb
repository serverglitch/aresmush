module AresMUSH  

  module Migrations
    class MigrationBeta93Update
      def require_restart
        false
      end
      
      def migrate
        
        Global.logger.debug "Adding debug setting."
        config = DatabaseMigrator.read_config_file("channels.yml")
        config['channels']['debug_discord'] = false
        DatabaseMigrator.write_config_file("channels.yml", config)
        
        Global.logger.debug "Adding content warnings."
        config = DatabaseMigrator.read_config_file("scenes.yml")
        config['scenes']['content_warnings'] = [
          "graphic violence",
          "sexual assault",
          "nsfw",
          "self-harm",
          "suicide",
          "bigotry",
          "torture"
        ]
        DatabaseMigrator.write_config_file("scenes.yml", config)
      end
    end    
  end
end