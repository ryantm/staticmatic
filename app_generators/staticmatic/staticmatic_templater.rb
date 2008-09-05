module StaticmaticGenerators
  extend Templater::Manifold
  class StaticmaticGenerator < Templater::Generator
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
    
    glob!

    #opts.on("-t", "--template=\"Your Template Directory\"", String,
    #         "Use a custom template for this project") { |options[:template]| }
  end
  
  add :setup, StaticmaticGenerator
end