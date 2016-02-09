[
  mappings: [
    "protocol": [
      doc: "Send via HTTP.",
      to: "exometer_core.reporters.exometer_report_influxdb.protocol",
      datatype: :atom,
      default: :http
    ],
    "host": [
      doc: "Host of InfluxDB.",
      to: "exometer_core.reporters.exometer_report_influxdb.host",
      datatype: :binary,
      default: "localhost"
    ],
    "port": [
      doc: "Port of InfluxDB.",
      to: "exometer_core.reporters.exometer_report_influxdb.port",
      datatype: :integer,
      default: 8086
    ],
    "db": [
      doc: "Name of the DB in InfluxDB.",
      to: "exometer_core.reporters.exometer_report_influxdb.db",
      datatype: :binary,
      default: "my_database"
    ],
    "tags": [
      doc: "Want default tags?",
      to: "exometer_core.reporters.exometer_report_influxdb.tags",
      datatype: [list: :ip],
      default: [{"some_tag", "some_value"}, {"other_tag", "other_value"}]
    ]
  ],
  translations: [
    "tags": fn _mapping, tags, acc ->
      case String.split(tags, ":") do
        [tag, value] -> [
          {String.to_atom(tag), String.to_atom(value)}
          | acc ]
        x -> IO.puts "Bad tag:value Format: #{tags}"
          exit(1)
      end
    end,
  ]
]
