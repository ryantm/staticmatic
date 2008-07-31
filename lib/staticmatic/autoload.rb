module StaticMatic
  autoload :Builder,     'staticmatic/builder'
  autoload :Creator,     'staticmatic/creator'
  autoload :Config,      'staticmatic/config'
  autoload :Deprecation, 'staticmatic/deprecation'
  autoload :Previewer,   'staticmatic/previewer'
  autoload :Rescue,      'staticmatic/rescue'
  
  module Helpers
    autoload :AssetTagHelper,    'staticmatic/helpers/asset_tag_helper'
    autoload :DeprecatedHelpers, 'staticmatic/helpers/deprecated_helpers'
    autoload :PageHelper,        'staticmatic/helpers/page_helper'
    autoload :UrlHelper,         'staticmatic/helpers/url_helper'
  end
end

require 'staticmatic/actionpack_support/mime'
require 'staticmatic/actionpack_support/remove_partial_benchmark'
require 'staticmatic/actionpack_support/remove_controller_caching'