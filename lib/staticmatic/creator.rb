module StaticMatic
  class Creator
    class << self
      def setup(directory)
        FileUtils.mkdir(directory) unless File.exists?(directory)
        
        template_directory = Dir.glob(File.dirname(__FILE__) + "/templates/default/**")
        
        FileUtils.cp_r(template_directory, directory)
        
        unless File.exists?(directory + "/build")
          FileUtils.mkdir(directory + "/build")
          FileUtils.mkdir(directory + "/build/stylesheets")
        end
      end
    end
  end
end