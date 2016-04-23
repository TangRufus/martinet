require 'martinet/version'
require 'martinet/configuration'
require 'martinet/session'

module Martinet
end

require 'martinet/railtie' if defined?(Rails)
