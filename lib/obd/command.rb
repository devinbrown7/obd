module OBD
  class Command

    def initialize

    end

    def self.format_result command, result
      if result.nil? || result.empty?
        puts "Communication error: No data received. Check serial connection..."
        return ""
      end
      if is_command?(command) && result != "NO DATA"
        pid = pids[command.to_sym]
        pid[:formula].call convert_data(trim_data(result, pid[:size]))
      else
        result
      end
    end

    def self.to_hex command
      if is_command? command
        pid = pids[command.to_sym]
        "%02X%02X" % [pid[:mode], pid[:pid]]
      else
        command
      end
    end

    def self.is_command? command
      pids.keys.include? command.to_sym
    end

    def self.pid
      {
        "ATRV" => [:battery_voltage, lambda {|x| x.to_s}],
      }
    end

    def self.pids
      Pids.pids
    end

    def self.trim_data response, size
      response[4...(4 + size * 2)]
    end

    def self.convert_data response
      data = []
      response.chars.each_slice(2) {|a| data << a.join.hex }
      data
    end
  end
end
