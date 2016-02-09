use Mix.Config

config :exometer_core,
    reporters: [
        exometer_report_influxdb: [
                                    protocol: :http,              #%% send via http
                                    host: "localhost",            #%% host of InfluxDB
                                    port: 8086,                   #%% port of InfluxDB
                                    db: "my_database",            #%% name of the DB in InfluxDB
                                    tags: [some_tag: :some_value] #%% want default tags?
                                   ]
    ]
