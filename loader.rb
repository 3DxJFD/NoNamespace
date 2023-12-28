module NoNamespace
    module IntProcess
      
      # Define PLUGIN_PATH constant
      PLUGIN_PATH ||= File.dirname(__FILE__)
  
      # Require the necessary files
      require File.join(PLUGIN_PATH, 'main.rb')
      
      # Define other constants
      PLUGIN_PATH_IMAGE = File.join(PLUGIN_PATH, 'icons')
      
    end
end
