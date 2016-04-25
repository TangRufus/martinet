require 'martinet/version'
require 'martinet/configuration'
require 'martinet/session'

require 'martinet/impersonation' if Martinet.configuration.enable_impersonation

module Martinet
end
