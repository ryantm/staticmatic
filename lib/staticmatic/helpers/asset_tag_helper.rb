module StaticMatic
  module Helpers
    module AssetTagHelper
      def compute_public_path(source, dir, ext = nil, include_host = true)
        path = "#{@relative_path_to_root}#{dir}/#{source}"
        path << ".#{ext}" if ext
        path
      end
    end
  end
end