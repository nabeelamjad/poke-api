require 'logger'
require 'time'

module Poke
  module API
    module Logging
      @@loggers = {}
      @@log_level = :INFO
      @@formatter = proc do |severity, datetime, progname, msg|
        sev_color = ['INFO', 'DEBUG', 'ANY'].include?(severity) ? "\e[32m" : "\e[31m"

        "[\e[36m%s\e[0m]: #{sev_color}%-5s\e[0m > \e[33m%-25s\e[0m --: %s\n" \
          % [datetime.iso8601, severity, progname, msg]
      end

      def logger
        @@loggers[self.class.name] ||= Logger.new(STDOUT).tap do |logger| 
          logger.progname = self.class.name == 'Module' ? self.name : self.class.name
          logger.level = Logger.const_get(@@log_level)
          logger.formatter = @@formatter
        end
      end

      def self.log_level=(level)
        @@log_level = level
      end

      def self.formatter=(formatter)
        @@formatter = formatter
      end
    end
  end
end
