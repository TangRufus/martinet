require 'martinet/version'
require 'martinet/configuration'
require 'martinet/session'
require 'martinet/impersonation'

module Martinet
end

require 'martinet/railtie' if defined?(Rails)
