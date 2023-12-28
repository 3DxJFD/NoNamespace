# This file needs to be moved to the SU Plugins folder to register the extension.

module NoNamespace
    module IntProcess
  
      EXTENSION = SketchupExtension.new(
        'IntProcess',  # The name of the extension as it will appear in SketchUp
        'NoNamespace/loader.rb'  # The path to the loader file
      )
      EXTENSION.instance_eval {
        self.description= 'Adds an extension.'
        self.version=     '0.0.0'
        self.copyright=   "©2023"
        self.creator=     'JFD / SU Community'
      }
      Sketchup.register_extension(EXTENSION, true) 
  
    end # extension submodule
  end # top level namespace module
