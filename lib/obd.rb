require "serialport"

require_relative "obd/command"
require_relative "obd/connection"
require_relative "obd/pids"

module OBD
  def self.connect *args
    self::Connection.new(*args)
  end
end
