module AresMUSH
  module Manage    
    class CronEventHandler
      def on_event(event)
        config = Global.read_config("backup", "backup_cron")
        return if !Cron.is_cron_match?(config, event.time)
        
        Global.logger.debug "Starting backup."
        
        Manage.perform_backup(nil)
      end
    end    
  end
end