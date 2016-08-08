module Poke
  module API
    module Auth
      class Ticket
        include Logging
        attr_reader :start, :ends, :expire

        def initialize
          @expire = nil
          @start  = nil
          @ends   = nil
        end

        def has_ticket?
          return true if @start && @ends && @expire
          false
        end

        def set_ticket(auth)
          @expire = auth[:expire_timestamp_ms]
          @start  = auth[:start]
          @ends   = auth[:end]
        end

        def is_new_ticket?(new_ticket_time)
          return true unless @expire && new_ticket_time > @expire
          false
        end

        def get_ticket
          return false unless check_ticket
          true
        end

        private

        def check_ticket
          return false unless has_ticket?
          now = Helpers.fetch_time

          if now < (@expire - 10000)
            duration = format('%02d:%02d:%02d', *Helpers.format_time_diff(now, @expire))
            logger.info "[+] Auth ticket is valid for #{duration}"
            return true
          end

          @expire, @start, @ends = nil
          logger.info '[+] Removed expired auth ticket'
          false
        end
      end
    end
  end
end
