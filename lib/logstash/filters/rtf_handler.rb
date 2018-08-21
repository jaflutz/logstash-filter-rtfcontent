require_relative "external_command_handler"

class RtfHandler < ExternalCommandHandler

  DEFAULT = [
    '/usr/bin/unrtf', '--text', '__FILE__'
  ].freeze

  def initialize
    @content_type = 'application/rtf'
    @command = DEFAULT
  end

end
