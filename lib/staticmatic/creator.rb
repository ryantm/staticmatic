module StaticMatic
  class Creator
    class << self
      def setup(directory)
        FileUtils.cp_r(File.dirname(__FILE__) + "/templates/default/.", directory)
        FileUtils.mkdir_p(directory + "/build/stylesheets")
      end
    end
  end
end