# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "tempfile"
require_relative "rtf_handler"

# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Rtfcontent < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "rtfcontent"

  # Replace the message with this value.
  #config :message, :validate => :string, :default => "Hello World!"

  config :input_field, :validate => :string
  config :output_field, :validate => :string


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    #if @message
      # Replace the event message with our message as configured in the
      # config file.
      #event.set("message", @message)
    #end

    file = Tempfile.new('test')
    file.write(event.get(@input_field))

    #fulltext = Plaintext::Resolver.new(file, 'application/rtf').text
    rtf_handler = RtfHandler.new
    fulltext = rtf_handler.text(file)

    file.close

    # run wkhtmltopdf here, use file.path
    # # wkhtmltopdf <file.path here> output.pdf
    #
    file.unlink

    # filter_matched should go in the last line of our successful code
    event.set(@output_field, fulltext)
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Rtfcontent
