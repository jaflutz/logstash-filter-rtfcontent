require 'pathname'
class ExternalCommandHandler
  require 'fileutils'

  def shellout(cmd, options = {}, &block)
    mode = "r+"
    IO.popen(cmd, mode) do |io|
      io.set_encoding("ASCII-8BIT") if io.respond_to?(:set_encoding)
      io.close_write unless options[:write_stdin]
      block.call(io) if block_given?
    end
  end

  FILE_PLACEHOLDER = '__FILE__'.freeze

  def text(file)
    cmd = @command.dup
    cmd[cmd.index(FILE_PLACEHOLDER)] = Pathname(file).to_s
    shellout(cmd){ |io| io.read }.to_s
  end

  def accept?(content_type)
    super and available?
  end

  def available?
    @command.present? and File.executable?(@command[0])
  end

  def self.available?
    new.available?
  end

  def accept?(content_type)
    if @content_type
      content_type == @content_type
    elsif @content_types
      @content_types.include? content_type
    else
      false
    end
  end
end
