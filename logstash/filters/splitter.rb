require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::Splitter < LogStash::Filters::Base

    config_name "splitter"
    plugin_status "experimental"

    # What to label this instance of Tattle.
    #
    # This is helpful as you could use multiple instances of Tattle - this would
    # help identify which is actually being used. 
    #
    # Default is no label.
    config :splitme, :validate => :string, :default => nil

    config :spliton, :validate => :string, :default => nil

    config :returnwhich, :validate => :number, :default => nil


    public
    def register
        # say nothing, act casual.
    end

    public
    def filter(event)
        return unless filter?(event)

        begin
            # TODO: Put some stuff in here to verify array length.
            if not splitme.nil? and not spliton.nil?
                if event[@splitme][0].include?(@spliton)
                    parts = event[@splitme][0].split(@spliton)
                    event[@splitme] = parts[@returnwhich]
                    # TODO; make this more flexible
                    # this is really just set up for my use case
                    newkey = @spliton.gsub("=", "")
                    event[newkey] = parts[@returnwhich +1, parts.length]
                end
            end
            filter_matched(event)
        rescue => e
            @logger.warn("Splitter issues: ", :exception => e, :backtrace => e.backtrace, :message => event["@message"])
        end


    end

end
