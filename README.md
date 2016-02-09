exit = Exometer Influxdb Test
=====

A small tool to get started with metrics and InfluxDB in Elixir.

Requirements
-----------

- [rebar3](https://github.com/rebar/rebar3)
- [InfluxDB](https://influxdata.com/downloads/)
- [Grafana](http://grafana.org/download/) (optional)

Build
-----

    $ mix release

Quick Start
-----------

* [Install and start](https://docs.influxdata.com/influxdb/v0.9/introduction/installation/) InfluxDB on your local machine.
* [Create](https://docs.influxdata.com/influxdb/v0.9/introduction/getting_started/) a Database
* Alter config/exit.conf accordingly
* Execute
    $ rel/exit/bin/exit console

A metric called "my_counter" should appear in your InfluxDB database. This
counter in incremented every second and resetted randomly within 60 seconds. The
counter can be visualized with e.g. Grafana.
