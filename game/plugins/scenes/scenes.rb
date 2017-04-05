$:.unshift File.dirname(__FILE__)

load "lib/helpers.rb"
load "lib/scene_model.rb"
load "lib/scene_join_cmd.rb"
load "lib/scene_privacy_cmd.rb"
load "lib/scene_set_cmd.rb"
load "lib/scene_start_cmd.rb"
load "lib/scene_stop_cmd.rb"
load "lib/scenes_cmd.rb"
load "templates/scenes_list_template.rb"

module AresMUSH
  module Scenes
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("scenes", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.help_files
      [ "help/scene.md" ]
    end
 
    def self.config_files
      [ "config_scenes.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "scene"
        case cmd.switch
        when "join"
          return SceneJoinCmd
        when "set"
          return SceneSetCmd
        when "start"
          return SceneStartCmd
        when "stop"
          return SceneStopCmd
        when "privacy"
          return ScenePrivacyCmd
        end
      when "scenes"
        return ScenesCmd
      when "wear"
        return WearCmd
      end
      
      nil
    end

    def self.get_event_handler(event_name) 
      nil
    end
  end
end