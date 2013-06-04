# Tattle Filter
#
# This filter is really just meant for debugging. This will dump to a logger
# whatever is in the 'event' object.
#
require "logstash/filters/base"
require "logstash/namespace"

# This is really simple and isn't meant for production use. It can be put between
# other filters in your pipeline so you can see what happens to the data as It
# passes.
#
# By default, Tattle shows a simplified format of the event, just displaying the
# message/tags/type/timestamp. But with the showevent option, the raw message
# can be displayed. This can be useful to display fields.
#
# Sample config:
#
#   filter {
#       tattle {
#           type => "foo"
#           label => "instance#1"
#       }
#
#       otherfilter {
#       }
#
#       tattle {
#           type => "foo"
#           label => "instance#2"
#       }
#   }
#


class LogStash::Filters::Tattle < LogStash::Filters::Base

    config_name "tattle"
    plugin_status "experimental"

    # What to label this instance of Tattle.
    #
    # This is helpful as you could use multiple instances of Tattle - this would
    # help identify which is actually being used. 
    #
    # Default is no label.
    config :label, :validate => :string, :default => nil

    # show the json event structure. This is helpful if you want to display @fields
    config :showevent, :validate => :boolean, :default => false

    public
    def register
        # say nothing, act casual.
    end

    public
    def filter(event)

        if label.nil?
            @logger.info("TATTLE:\n\tmessage:#{event.message}\n\ttags:#{event.tags}\n\ttype:#{event.type}\n\ttimestamp:#{event.timestamp}\n")
            if @showevent
                @logger.info("TATTLE:event\n", :event => event )
            end
            @logger.info("\n")
        else
            @logger.info("TATTLE:#{label}:\n\tmessage:#{event.message}\n\ttags:#{event.tags}\n\ttype:#{event.type}\n\ttimestamp:#{event.timestamp}\n")
            if @showevent
                @logger.info("TATTLE:#{label}:event\n", :event => event )
            end
            @logger.info("\n")
        end
    end

end
