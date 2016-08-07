module Poke
  module API
    module Auth
      class Ticket
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

          now_ms = (Time.now.to_f * 1000).to_i
          return true if now_ms < (@expire - 10000)

          @expire = nil
          @start  = nil
          @ends   = nil
          false
        end
      end
    end
  end
end
