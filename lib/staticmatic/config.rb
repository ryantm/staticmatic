class StaticMatic::Config
  class << self
    def defaults
      @defaults ||= {
        :host               => "0.0.0.0",
        :port               => "3000",
        :sass_options       => {},
        :haml_options       => {},
        :use_build_tracking => true
      }
    end

    def setup(settings = {})
      @configuration = defaults.merge(settings)
    end

    def key?(key)
      @configuration.key?(key)
    end

    def [](key)
      (@configuration||={})[key]
    end

    def []=(key,val)
      @configuration[key] = val
    end

    def delete(key)
      @configuration.delete(key)
    end

    def fetch(key, default)
      @configuration.fetch(key, default)
    end

    def to_hash
      @configuration
    end
  end
end