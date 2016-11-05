module OBD
  class Pids
    def self.byte_to_percent byte
      byte * 100.0 / 255.0
    end

    @@obd_standards = [{1 => "OBD-II as defined by the CARB"},
      {2 => "OBD as defined by the EPA"},
      {3 => "OBD and OBD-II"},
      {4 => "OBD-I"},
      {5 => "Not OBD compliant"},
      {6 => "EOBD (Europe)"},
      {7 => "EOBD and OBD-II"},
      {8 => "EOBD and OBD"},
      {9 => "EOBD, OBD and OBD II"},
      {10 => "JOBD (Japan)"},
      {11 => "JOBD and OBD II"},
      {12 => "JOBD and EOBD"},
      {13 => "JOBD, EOBD, and OBD II"},
      {14 => "Reserved"},
      {15 => "Reserved"},
      {16 => "Reserved"},
      {17 => "Engine Manufacturer Diagnostics (EMD)"},
      {18 => "Engine Manufacturer Diagnostics Enhanced (EMD+)"},
      {19 => "Heavy Duty On-Board Diagnostics (Child/Partial) (HD OBD-C)"},
      {20 => "Heavy Duty On-Board Diagnostics (HD OBD)"},
      {21 => "World Wide Harmonized OBD (WWH OBD)"},
      {22 => "Reserved"},
      {23 => "Heavy Duty Euro OBD Stage I without NOx control (HD EOBD-I)"},
      {24 => "Heavy Duty Euro OBD Stage I with NOx control (HD EOBD-I N)"},
      {25 => "Heavy Duty Euro OBD Stage II without NOx control (HD EOBD-II)"},
      {26 => "Heavy Duty Euro OBD Stage II with NOx control (HD EOBD-II N)"},
      {27 => "Reserved"},
      {28 => "Brazil OBD Phase 1 (OBDBr-1)"},
      {29 => "Brazil OBD Phase 2 (OBDBr-2)"},
      {30 => "Korean OBD (KOBD)"},
      {31 => "India OBD I (IOBD I)"},
      {32 => "India OBD II (IOBD II)"},
      {33 => "Heavy Duty Euro OBD Stage VI (HD EOBD-IV)"},
      {(34..250) => "Reserved"},
      {(251..255) => "Not available for assignment (SAE J1939 special meaning)"}]

    @@fuel_types = [{0 => "Not available"},
      {1 => "Gasoline"},
      {2 => "Methanol"},
      {3 => "Ethanol"},
      {4 => "Diesel"},
      {5 => "LPG"},
      {6 => "CNG"},
      {7 => "Propane"},
      {8 => "Electric"},
      {9 => "Bifuel running Gasoline"},
      {10 => "Bifuel running Methanol"},
      {11 => "Bifuel running Ethanol"},
      {12 => "Bifuel running LPG"},
      {13 => "Bifuel running CNG"},
      {14 => "Bifuel running Propane"},
      {15 => "Bifuel running Electricity"},
      {16 => "Bifuel running electric and combustion engine"},
      {17 => "Hybrid gasoline"},
      {18 => "Hybrid Ethanol"},
      {19 => "Hybrid Diesel"},
      {20 => "Hybrid Electric"},
      {21 => "Hybrid running electric and combustion engine"},
      {22 => "Hybrid Regenerative"},
      {23 => "Bifuel running diesel"}]

    def self.elm
      [
        {version: "1.0", command: "@1", description: "display the device description", group: "General"},
        {version: "1.3", command: "@2", description: "display the device identifier", group: "General"},
        {version: "1.3", command: "@3 cccccccccccc", description: "store the device identifier", group: "General"},
        {version: "1.0", command: "<CR>", description: "repeat the last command", group: "General"},
        {version: "1.0", command: "AL", description: "Allow Long (>7 byte) messages", group: "OBD"},
        {version: "1.2", command: "AR", description: "Automatic Receive", group: "OBD"},
        {version: "1.2", command: "AT0", description: "Adaptive Timing Off", group: "OBD"},
        {version: "1.2", command: "AT1", description: "Adaptive Timing Auto1", group: "OBD"},
        {version: "1.2", command: "AT2", description: "Adaptive Timing Auto2", group: "OBD"},
        {version: "1.0", command: "BD", description: "perform a Buffer Dump", group: "OBD"},
        {version: "1.0", command: "BI", description: "Bypass the Initialization sequence", group: "OBD"},
        {version: "1.2", command: "BRD hh", description: "try Baud rate Divisor hh", group: "General"},
        {version: "1.2", command: "BRT hh", description: "set Baud Rate handshake Timeout", group: "General"},
        {version: "1.0", command: "CAF0", description: "CAN Automatic Formatting Off", group: "CAN"},
        {version: "1.0", command: "CAF1", description: "CAN Automatic Formatting On", group: "CAN"},
        {version: "1.4", command: "CEA", description: "turn off CAN Extended Addressing", group: "CAN"},
        {version: "1.4", command: "CEA hh", description: "use CAN Extended Address hh", group: "CAN"},
        {version: "1.0", command: "CF hh hh hh hh", description: "set the ID Filter to hhhhhhhh", group: "CAN"},
        {version: "1.0", command: "CF hhh", description: "set the ID Filter to hhh", group: "CAN"},
        {version: "1.0", command: "CFC0", description: "CAN Flow Control Off", group: "CAN"},
        {version: "1.0", command: "CFC1", description: "CAN Flow Control On", group: "CAN"},
        {version: "1.0", command: "CM hh hh hh hh", description: "set the ID Mask to hhhhhhhh", group: "CAN"},
        {version: "1.0", command: "CM hhh", description: "set the ID Mask to hhh", group: "CAN"},
        {version: "1.0", command: "CP hh", description: "set CAN Priority (only for 29 bit)", group: "CAN"},
        {version: "1.4b", command: "CRA", description: "reset CAN Receive Address filters", group: "CAN"},
        {version: "1.3", command: "CRA hhh", description: "set CAN Receive Address to hhh", group: "CAN"},
        {version: "1.3", command: "CRA hh hh hh hh", description: "set CAN Receive Address to hhhhhhhh", group: "CAN"},
        {version: "1.0", command: "CS", description: "show the CAN Status", group: "CAN"},
        {version: "1.4b", command: "CSM0", description: "CAN Silent Mode Off", group: "CAN"},
        {version: "1.4b", command: "CSM1", description: "CAN Silent Mode On", group: "CAN"},
        {version: "1.0", command: "CV dddd", description: "Calibrate the Voltage to dd.dd volts", group: "Volts"},
        {version: "1.4", command: "CV 0000", description: "Restore CV value to factory setting", group: "Volts"},
        {version: "1.0", command: "D", description: "set all to Defaults", group: "General"},
        {version: "1.3", command: "D0", description: "display of the DLC Off", group: "CAN"},
        {version: "1.3", command: "D1", description: "display of the DLC On", group: "CAN"}
      ]
    end

    def self.pids
      {
        pids_supported_1: {
          mode: 0x01, pid: 0x00, size: 4, unit: "", description: "PIDs supported [01 - 20]",
          formula: -> (x) { 0 } #TODO
        },
        monitor_status_since_clear: {
          mode: 0x01, pid: 0x01, size: 4, unit: "", description: "Monitor status since DTCs cleared)",
          formula: -> (x) { 0 } #TODO
        },
        freeze_dtc: {
          mode: 0x01, pid: 0x02, size: 2, unit: "", description: "Freeze DTC",
          formula: -> (x) { 0 } #TODO
        },
        fuel_system_status: {
          mode: 0x01, pid: 0x03, size: 2, unit: "", description: "Fuel system status",
          formula: -> (x) { 0 } #TODO
        },
        calculated_engine_load: {
          mode: 0x01, pid: 0x04, size: 1, unit: "%", description: "Calculated engine load",
          formula: -> (x) { Pids.byte_to_percent x[0] } #WIP
        },
        engine_coolent_temperature: {
          mode: 0x01, pid: 0x05, size: 1, unit: "", description: "Engine coolant temperature",
          formula: -> (x) { 0 } #TODO
        },
        short_term_fuel_trim_bank_1: {
          mode: 0x01, pid: 0x06, size: 1, unit: :%, description: "Short term fuel trim—Bank 1",
          formula: -> (x) { x[0] / 1.28 - 100 } #WIP
        },
        long_term_fuel_trim_bank_1: {
          mode: 0x01, pid: 0x07, size: 1, unit: :%, description: "Long term fuel trim—Bank 1",
          formula: -> (x) { x[0] / 1.28 - 100 } #WIP
        },
        short_term_fuel_trim_bank_2: {
          mode: 0x01, pid: 0x08, size: 1, unit: :%, description: "Short term fuel trim—Bank 2",
          formula: -> (x) { x[0] / 1.28 - 100 } #WIP
        },
        long_term_fuel_trim_bank_2: {
          mode: 0x01, pid: 0x09, size: 1, unit: :%, description: "Long term fuel trim—Bank 2",
          formula: -> (x) { x[0] / 1.28 - 100 } #WIP
        },
        fuel_pressure: {
          mode: 0x01, pid: 0x0A, size: 1, unit: :kPa, description: "Fuel pressure (gauge pressure)",
          formula: -> (x) { 3 * x[0] } #WIP
        },
        intake_manifold_absolute_pressure: {
          mode: 0x01, pid: 0x0B, size: 1, unit: :%, description: "Intake manifold absolute pressure",
          formula: -> (x) { 3 * x[0] } #WIP
        },
        engine_rpm: {
          mode: 0x01, pid: 0x0C, size: 2, unit: :rpm, description: "Engine RPM",
          formula: -> (x) { ((256.0 * x[0]) + x[1]) / 4 }
        },
        vehicle_speed: {
          mode: 0x01, pid: 0x0D, size: 1, unit: :kmh, description: "Vehicle speed",
          formula: -> (x) { x[0] }
        },
        timing_advance: {
          mode: 0x01, pid: 0x0E, size: 1, unit: :*, description: "Timing advance",
          formula: -> (x) { x[0] / 2.0 - 64 }
        },
        intake_air_temperature: {
          mode: 0x01, pid: 0x0F, size: 1, unit: "°C", description: "Intake air temperature",
          formula: -> (x) { x[0] - 40 } #WIP
        },
        maf_air_flow_rate: {
          mode: 0x01, pid: 0x10, size: 2, unit: 'g/second', description: "MAF air flow rate",
          formula: -> (x) { ((256.0 * x[0]) + x[1]) / 100 } #WIP
        },
        throttle_position: {
          mode: 0x01, pid: 0x11, size: 1, unit: "%", description: "Throttle position",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        commanded_secondary_air_status: {
          mode: 0x01, pid: 0x12, size: 1, unit: "", description: "Commanded secondary air status",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensors_present_1: {
          mode: 0x01, pid: 0x13, size: 1, unit: "", description: "Oxygen sensors present (in 2 banks)",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_1: {
          mode: 0x01, pid: 0x14, size: 2, unit: "", description: "Oxygen Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_2: {
          mode: 0x01, pid: 0x15, size: 2, unit: "", description: "Oxygen Sensor 2",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_3: {
          mode: 0x01, pid: 0x16, size: 2, unit: "", description: "Oxygen Sensor 3",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_4: {
          mode: 0x01, pid: 0x17, size: 2, unit: "", description: "Oxygen Sensor 4",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_5: {
          mode: 0x01, pid: 0x18, size: 2, unit: "", description: "Oxygen Sensor 5",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_6: {
          mode: 0x01, pid: 0x19, size: 2, unit: "", description: "Oxygen Sensor 6",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_7: {
          mode: 0x01, pid: 0x1A, size: 2, unit: "", description: "Oxygen Sensor 7",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_1_8: {
          mode: 0x01, pid: 0x1B, size: 2, unit: "", description: "Oxygen Sensor 8",
          formula: -> (x) { 0 } #TODO
        },
        obd_standards_vehicle_conforms_to: {
          mode: 0x01, pid: 0x1C, size: 1, unit: "", description: "OBD standards this vehicle conforms to",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensors_present_2: {
          mode: 0x01, pid: 0x1D, size: 1, unit: "", description: "Oxygen sensors present (in 4 banks)",
          formula: -> (x) { 0 } #TODO
        },
        aux_input_status: {
          mode: 0x01, pid: 0x1E, size: 1, unit: "", description: "Auxiliary input status",
          formula: -> (x) { 0 } #TODO
        },
        run_time_since_engine_start: {
          mode: 0x01, pid: 0x1F, size: 2, unit: "second", description: "Run time since engine start",
          formula: -> (x) { (256.0 * x[0]) + x[1] } #WIP
        },
        pids_supported_2: {
          mode: 0x01, pid: 0x20, size: 4, unit: "", description: "PIDs supported [21 - 40]",
          formula: -> (x) { 0 } #TODO
        },
        distance_traveled_with_mil_on: {
          mode: 0x01, pid: 0x21, size: 2, unit: "km", description: "Distance traveled with malfunction indicator lamp (MIL) on",
          formula: -> (x) { (256.0 * x[0]) + x[1] } #WIP
        },
        fuel_rail_pressure: {
          mode: 0x01, pid: 0x22, size: 2, unit: "kPa", description: "Fuel Rail Pressure (relative to manifold vacuum)",
          formula: -> (x) { 0.079 * ((256.0 * x[0]) + x[1]) } #WIP
        },
        fuel_rail_gauge_pressure: {
          mode: 0x01, pid: 0x23, size: 2, unit: "kPa", description: "Fuel Rail Gauge Pressure (diesel, or gasoline direct injection)",
          formula: -> (x) { 10 * ((256.0 * x[0]) + x[1]) } #WIP
        },
        oxygen_sensor_2_1: {
          mode: 0x01, pid: 0x24, size: 4, unit: "", description: "Oxygen Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_2: {
          mode: 0x01, pid: 0x25, size: 4, unit: "", description: "Oxygen Sensor 2",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_3: {
          mode: 0x01, pid: 0x26, size: 4, unit: "", description: "Oxygen Sensor 3",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_4: {
          mode: 0x01, pid: 0x27, size: 4, unit: "", description: "Oxygen Sensor 4",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_5: {
          mode: 0x01, pid: 0x28, size: 4, unit: "", description: "Oxygen Sensor 5",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_6: {
          mode: 0x01, pid: 0x29, size: 4, unit: "", description: "Oxygen Sensor 6",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_7: {
          mode: 0x01, pid: 0x2A, size: 4, unit: "", description: "Oxygen Sensor 7",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2_8: {
          mode: 0x01, pid: 0x2B, size: 4, unit: "", description: "Oxygen Sensor 8",
          formula: -> (x) { 0 } #TODO
        },
        commanded_egr: {
          mode: 0x01, pid: 0x2C, size: 1, unit: "%", description: "Commanded EGR",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        egr_error: {
          mode: 0x01, pid: 0x2D, size: 1, unit: "%", description: "EGR Error",
          formula: -> (x) { (x[0] * 100.0 / 255.0) - 100 } #WIP
        },
        commanded_evaporative_purge: {
          mode: 0x01, pid: 0x2E, size: 1, unit: "%", description: "Commanded evaporative purge",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        fuel_tank_level_input: {
          mode: 0x01, pid: 0x2F, size: 1, unit: "%", description: "Fuel Tank Level Input",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        warm_ups_since_codes_cleared: {
          mode: 0x01, pid: 0x30, size: 1, unit: "%", description: "Warm-ups since codes cleared",
          formula: -> (x) { x[0] } #WIP
        },
        distance_traveled_since_codes_cleared: {
          mode: 0x01, pid: 0x31, size: 2, unit: "km", description: "Distance traveled since codes cleared",
          formula: -> (x) { 256.0 * x[0] + x[1] } #WIP
        },
        evap_system_vapor_pressure: {
          mode: 0x01, pid: 0x32, size: 2, unit: "Pa", description: "Evap. System Vapor Pressure",
          formula: -> (x) { ((256.0 * x[0]) + x[1]) / 4 } #WIP
        },
        absolute_barometric_pressure: {
          mode: 0x01, pid: 0x33, size: 1, unit: "kPa", description: "Absolute Barometric Pressure",
          formula: -> (x) { x[0] } #WIP
        },
        oxygen_sensor_1: {
          mode: 0x01, pid: 0x34, size: 4, unit: "", description: "Oxygen Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_2: {
          mode: 0x01, pid: 0x35, size: 4, unit: "", description: "Oxygen Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_3: {
          mode: 0x01, pid: 0x36, size: 4, unit: "", description: "Oxygen Sensor 3",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_4: {
          mode: 0x01, pid: 0x37, size: 4, unit: "", description: "Oxygen Sensor 4",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_5: {
          mode: 0x01, pid: 0x38, size: 4, unit: "", description: "Oxygen Sensor 5",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_6: {
          mode: 0x01, pid: 0x39, size: 4, unit: "", description: "Oxygen Sensor 6",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_7: {
          mode: 0x01, pid: 0x3A, size: 4, unit: "", description: "Oxygen Sensor 7",
          formula: -> (x) { 0 } #TODO
        },
        oxygen_sensor_8: {
          mode: 0x01, pid: 0x3B, size: 4, unit: "", description: "Oxygen Sensor 8",
          formula: -> (x) { 0 } #TODO
        },
        catalyst_temperature_bank_1_sensor_1: {
          mode: 0x01, pid: 0x3C, size: 2, unit: "", description: "Catalyst Temperature: Bank 1, Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        catalyst_temperature_bank_2_sensor_1: {
          mode: 0x01, pid: 0x3D, size: 2, unit: "", description: "Catalyst Temperature: Bank 2, Sensor 1",
          formula: -> (x) { 0 } #TODO
        },
        catalyst_temperature_bank_1_sensor_2: {
          mode: 0x01, pid: 0x3E, size: 2, unit: "", description: "Catalyst Temperature: Bank 1, Sensor 2",
          formula: -> (x) { 0 } #TODO
        },
        catalyst_temperature_bank_2_sensor_2: {
          mode: 0x01, pid: 0x3F, size: 2, unit: "", description: "Catalyst Temperature: Bank 2, Sensor 2",
          formula: -> (x) { 0 } #TODO
        },
        pids_supported_3: {
          mode: 0x01, pid: 0x40, size: 4, unit: "", description: "PIDs supported [41 - 60]",
          formula: -> (x) { 0 } #TODO
        },
        monitor_status_this_drive_cycle: {
          mode: 0x01, pid: 0x41, size: 4, unit: "", description: "Monitor status this drive cycle",
          formula: -> (x) { 0 } #TODO
        },
        control_module_voltage: {
          mode: 0x01, pid: 0x42, size: 2, unit: "V", description: "Control module voltage",
          formula: -> (x) { ((256.0 * x[0]) + x[1]) / 1000 } #WIP
        },
        absolute_load_value: {
          mode: 0x01, pid: 0x43, size: 2, unit: "", description: "Absolute load value",
          formula: -> (x) { 0 } #TODO
        },
        fuel–air_commanded_equivalence_ratio: {
          mode: 0x01, pid: 0x44, size: 2, unit: "fuel/air", description: "Fuel–Air commanded equivalence ratio",
          formula: -> (x) { (256.0 * x[0] + x[1]) * 100.0 / 255.0 }
        },
        relative_throttle_position: {
          mode: 0x01, pid: 0x45, size: 1, unit: "%", description: "Relative throttle position",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        ambient_air_temperature: {
          mode: 0x01, pid: 0x46, size: 1, unit: "°C", description: "Ambient air temperature",
          formula: -> (x) { x[0] - 40 } #WIP
        },
        absolute_throttle_position_b: {
          mode: 0x01, pid: 0x47, size: 1, unit: "%", description: "Absolute throttle position B",
          formula: -> (x) {  } #WIP
        },
        absolute_throttle_position_c: {
          mode: 0x01, pid: 0x48, size: 1, unit: "%", description: "Absolute throttle position C",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        accelerator_pedal_position_d: {
          mode: 0x01, pid: 0x49, size: 1, unit: "%", description: "Accelerator pedal position D",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        accelerator_pedal_position_e: {
          mode: 0x01, pid: 0x4A, size: 1, unit: "%", description: "Accelerator pedal position E",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        accelerator_pedal_position_f: {
          mode: 0x01, pid: 0x4B, size: 1, unit: "%", description: "Accelerator pedal position F",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        commanded_throttle_actuator: {
          mode: 0x01, pid: 0x4C, size: 1, unit: "%", description: "Commanded throttle actuator",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        time_run_with_mil_on: {
          mode: 0x01, pid: 0x4D, size: 2, unit: "minute", description: "Time run with MIL on",
          formula: -> (x) { 256.0 * x[0] + x[1] } #WIP
        },
        time_since_trouble_codes_cleared: {
          mode: 0x01, pid: 0x4E, size: 2, unit: "minute", description: "Time since trouble codes cleared",
          formula: -> (x) { 256.0 * x[0] + x[1] } #WIP
        },
        max_fuel_air_equivalence_ratio: {
          mode: 0x01, pid: 0x4F, size: 4, unit: "", description: "Maximum value for Fuel–Air equivalence ratio, oxygen sensor voltage, oxygen sensor current, and intake manifold absolute pressure",
          formula: -> (x) { x[0] } #TODO } #TODO
        },
        max_air_flow_rate_from_maf_sensor: {
          mode: 0x01, pid: 0x50, size: 4, unit: "g/s", description: "Maximum value for air flow rate from mass air flow sensor",
          formula: -> (x) { x[0] * 10 } #WIP
        },
        fuel_type: {
          mode: 0x01, pid: 0x51, size: 1, unit: "", description: "Fuel Type",
          formula: -> (x) { 0 } #TODO
        },
        ethanol_fuel_percent: {
          mode: 0x01, pid: 0x52, size: 1, unit: "%", description: "Ethanol fuel %",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        absolute_evap_system_vapor_pressure: {
          mode: 0x01, pid: 0x53, size: 2, unit: "kPa", description: "Absolute Evap system Vapor Pressure",
          formula: -> (x) { (256.0 * x[0] + x[1]) / 200 } #WIP
        },
        evap_system_vapor_pressure_2: {
          mode: 0x01, pid: 0x54, size: 2, unit: "Pa", description: "Evap system vapor pressure",
          formula: -> (x) { (256.0 * x[0] + x[1]) - 32767 } #WIP
        },
        short_term_secondary_oxygen_sensor_trim_1_3: {
          mode: 0x01, pid: 0x55, size: 2, unit: "", description: "Short term secondary oxygen sensor trim, A: bank 1, B: bank 3",
          formula: -> (x) { x[0] } #TODO } #TODO
        },
        long_term_secondary_oxygen_sensor_trim_1_3: {
          mode: 0x01, pid: 0x56, size: 2, unit: "", description: "Long term secondary oxygen sensor trim, A: bank 1, B: bank 3",
          formula: -> (x) { x[0] } #TODO } #TODO
        },
        short_term_secondary_oxygen_sensor_trim_2_4: {
          mode: 0x01, pid: 0x57, size: 2, unit: "", description: "Short term secondary oxygen sensor trim, A: bank 2, B: bank 4",
          formula: -> (x) { x[0] } #TODO } #TODO
        },
        long_term_secondary_oxygen_sensor_trim_2_4: {
          mode: 0x01, pid: 0x58, size: 2, unit: "", description: "Long term secondary oxygen sensor trim, A: bank 2, B: bank 4",
          formula: -> (x) { x[0] } #TODO } #TODO
        },
        fuel_rail_absolute_pressure: {
          mode: 0x01, pid: 0x59, size: 2, unit: "kPa", description: "Fuel rail absolute pressure",
          formula: -> (x) { 10 * (256.0 * x[0] + x[1]) } #WIP
        },
        relative_accelerator_pedal_position: {
          mode: 0x01, pid: 0x5A, size: 1, unit: "%", description: "Relative accelerator pedal position",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        hybrid_battery_pack_remaining_life: {
          mode: 0x01, pid: 0x5B, size: 1, unit: "%", description: "Hybrid battery pack remaining life",
          formula: -> (x) { x[0] * 100.0 / 255.0 } #WIP
        },
        engine_oil_temperature: {
          mode: 0x01, pid: 0x5C, size: 1, unit: "°C", description: "Engine oil temperature",
          formula: -> (x) { x[0] - 40 } #WIP
        },
        fuel_injection_timing: {
          mode: 0x01, pid: 0x5D, size: 2, unit: "°", description: "Fuel injection timing",
          formula: -> (x) { ((256.0 * x[0] + x[1]) / 128.0) - 210.0 } #WIP
        },
        engine_fuel_rate: {
          mode: 0x01, pid: 0x5E, size: 2, unit: "L/h", description: "Engine fuel rate",
          formula: -> (x) { (256.0 * x[0] + x[1]) / 20.0 } #WIP
        },
        vehicle_emission_requirements: {
          mode: 0x01, pid: 0x5F, size: 1, unit: "", description: "Emission requirements to which vehicle is designed",
          formula: -> (x) { 0 } #TODO
        },
        pids_supported_4: {
          mode: 0x01, pid: 0x60, size: 4, unit: "", description: "PIDs supported [61 - 80]",
          formula: -> (x) { 0 } #TODO
        },
        drivers_demand_engine_percent_torque: {
          mode: 0x01, pid: 0x61, size: 1, unit: "%", description: "Driver's demand engine - percent torque",
          formula: -> (x) { x[0] - 125 } #WIP
        },
        actual_engine_percent_torque: {
          mode: 0x01, pid: 0x62, size: 1, unit: "%", description: "Actual engine - percent torque",
          formula: -> (x) { x[0] - 125 } #WIP
        },
        engine_reference_torque: {
          mode: 0x01, pid: 0x63, size: 2, unit: "Nm", description: "Engine reference torque",
          formula: -> (x) { 256.0 * x[0] + [1] } #WIP
        },
        engine_percent_torque_data: {
          mode: 0x01, pid: 0x64, size: 5, unit: "", description: "Engine percent torque data",
          formula: -> (x) { 0 } #TODO
        },
        auxiliary_io_supported: {
          mode: 0x01, pid: 0x65, size: 2, unit: "", description: "Auxiliary input / output supported",
          formula: -> (x) { 0 } #TODO
        },
        mass_air_flow_sensor: {
          mode: 0x01, pid: 0x66, size: 5, unit: "", description: "Mass air flow sensor",
          formula: -> (x) { 0 } #TODO
        },
        engine_coolant_temperature: {
          mode: 0x01, pid: 0x67, size: 3, unit: "°C", description: "Engine coolant temperature",
          formula: -> (x) { x[0] - 40 }
        },
        intake_air_temperature_sensor: {
          mode: 0x01, pid: 0x68, size: 7, unit: "", description: "Intake air temperature sensor",
          formula: -> (x) { 0 } #TODO
        },
        commanded_egr_and_egr_error: {
          mode: 0x01, pid: 0x69, size: 7, unit: "", description: "Commanded EGR and EGR Error",
          formula: -> (x) { 0 } #TODO
        },
        commanded_diesel_intake_air_flow: {
          mode: 0x01, pid: 0x6A, size: 5, unit: "", description: "Commanded Diesel intake air flow control and relative intake air flow position",
          formula: -> (x) { 0 } #TODO
        },
        exhaust_gas_recirculation_temperature: {
          mode: 0x01, pid: 0x6B, size: 5, unit: "", description: "Exhaust gas recirculation temperature",
          formula: -> (x) { 0 } #TODO
        },
        commanded_throttle_actuator_control: {
          mode: 0x01, pid: 0x6C, size: 5, unit: "", description: "Commanded throttle actuator control and relative throttle position",
          formula: -> (x) { 0 } #TODO
        },
        fuel_pressure_control_system: {
          mode: 0x01, pid: 0x6D, size: 6, unit: "", description: "Fuel pressure control system",
          formula: -> (x) { 0 } #TODO
        },
        injection_pressure_control_system: {
          mode: 0x01, pid: 0x6E, size: 5, unit: "", description: "Injection pressure control system",
          formula: -> (x) { 0 } #TODO
        },
        turbocharger_compressor_inlet_pressure: {
          mode: 0x01, pid: 0x6F, size: 3, unit: "", description: "Turbocharger compressor inlet pressure",
          formula: -> (x) { 0 } #TODO
        },
        boost_pressure_control: {
          mode: 0x01, pid: 0x70, size: 9, unit: "", description: "Boost pressure control",
          formula: -> (x) { 0 } #TODO
        },
        variable_geometry_turbo_control: {
          mode: 0x01, pid: 0x71, size: 5, unit: "", description: "Variable Geometry turbo (VGT) control",
          formula: -> (x) { 0 } #TODO
        },
        wastegate_control: {
          mode: 0x01, pid: 0x72, size: 5, unit: "", description: "Wastegate control",
          formula: -> (x) { 0 } #TODO
        },
        exhaust_pressure: {
          mode: 0x01, pid: 0x73, size: 5, unit: "", description: "Exhaust pressure",
          formula: -> (x) { 0 } #TODO
        },
        turbocharger_rpm: {
          mode: 0x01, pid: 0x74, size: 5, unit: "", description: "Turbocharger RPM",
          formula: -> (x) { 0 } #TODO
        },
        turbocharger_temperature: {
          mode: 0x01, pid: 0x75, size: 7, unit: "", description: "Turbocharger temperature",
          formula: -> (x) { 0 } #TODO
        },
        turbocharger_temperature_2: {
          mode: 0x01, pid: 0x76, size: 7, unit: "", description: "Turbocharger temperature",
          formula: -> (x) { 0 } #TODO
        },
        charge_air_cooler_temperature: {
          mode: 0x01, pid: 0x77, size: 5, unit: "", description: "Charge air cooler temperature (CACT)",
          formula: -> (x) { 0 } #TODO
        },
        exhaust_gas_temperature_bank_1: {
          mode: 0x01, pid: 0x78, size: 9, unit: "", description: "Exhaust Gas temperature (EGT) Bank 1",
          formula: -> (x) { 0 } #TODO
        },
        exhaust_gas_temperature_bank_2: {
          mode: 0x01, pid: 0x79, size: 9, unit: "", description: "Exhaust Gas temperature (EGT) Bank 2",
          formula: -> (x) { 0 } #TODO
        },
        diesel_particulate_filter: {
          mode: 0x01, pid: 0x7A, size: 7, unit: "", description: "Diesel particulate filter (DPF)",
          formula: -> (x) { 0 } #TODO
        },
        diesel_particulate_filter_2: {
          mode: 0x01, pid: 0x7B, size: 7, unit: "", description: "Diesel particulate filter (DPF)",
          formula: -> (x) { 0 } #TODO
        },
        diesel_particulate_filter_temperature: {
          mode: 0x01, pid: 0x7C, size: 9, unit: "", description: "Diesel Particulate filter (DPF) temperature",
          formula: -> (x) { 0 } #TODO
        },
        nox_nte_control_area_status: {
          mode: 0x01, pid: 0x7D, size: 1, unit: "", description: "NOx NTE control area status",
          formula: -> (x) { 0 } #TODO
        },
        pm_nte_control_area_status: {
          mode: 0x01, pid: 0x7E, size: 1, unit: "", description: "PM NTE control area status",
          formula: -> (x) { 0 } #TODO
        },
        engine_run_time: {
          mode: 0x01, pid: 0x7F, size: 1, unit: "", description: "Engine run time",
          formula: -> (x) { 0 } #TODO
        },
        pids_supported_5: {
          mode: 0x01, pid: 0x80, size: 4, unit: "", description: "PIDs supported [81 - A0]",
          formula: -> (x) { 0 } #TODO
        },
        engine_run_time_aecd_1: {
          mode: 0x01, pid: 0x81, size: 2, unit: "", description: "Engine run time for Auxiliary Emissions Control Device(AECD)",
          formula: -> (x) { 0 } #TODO
        },
        engine_run_time_aecd_2: {
          mode: 0x01, pid: 0x82, size: 2, unit: "", description: "Engine run time for Auxiliary Emissions Control Device(AECD)",
          formula: -> (x) { 0 } #TODO
        },
        nox_sensor: {
          mode: 0x01, pid: 0x83, size: 5, unit: "", description: "NOx sensor",
          formula: -> (x) { 0 } #TODO
        },
        manifold_surface_temperature: {
          mode: 0x01, pid: 0x84, size: 0, unit: "", description: "Manifold surface temperature",
          formula: -> (x) { 0 } #TODO
        },
        nox_reagent_system: {
          mode: 0x01, pid: 0x85, size: 0, unit: "", description: "NOx reagent system",
          formula: -> (x) { 0 } #TODO
        },
        particulate_matter_sensor: {
          mode: 0x01, pid: 0x86, size: 0, unit: "", description: "Particulate matter (PM) sensor",
          formula: -> (x) { 0 } #TODO
        },
        intake_manifold_absolute_pressure_2: {
          mode: 0x01, pid: 0x87, size: 0, unit: "", description: "Intake manifold absolute pressure",
          formula: -> (x) { 0 } #TODO
        },
        pids_supported_6: {
          mode: 0x01, pid: 0xA0, size: 4, unit: "", description: "PIDs supported [A1 - C0]",
          formula: -> (x) { 0 } #TODO
        },
        pids_supported_7: {
          mode: 0x01, pid: 0xC0, size: 4, unit: "", description: "PIDs supported [C1 - E0]",
          formula: -> (x) { 0 } #TODO
        },
        unknown_1: {
          mode: 0x01, pid: 0xC3, size: 0, unit: "", description: "?",
          formula: -> (x) { 0 } #TODO
        },
        unknown_2: {
          mode: 0x01, pid: 0xC4, size: 0, unit: "", description: "?",
          formula: -> (x) { 0 } #TODO
        }
      }
    end
  end
end
