ExIT = Exometer Influxdb Test
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

Install and start InfluxDB on your local machine (alter priv/app.config
accordingly) and then execute

    $ rel/ExIT/bin/exit console

A metric called "my_counter" should appear in your InfluxDB database. This
counter in incremented every second and resetted randomly within 60 seconds. The
counter can be visualized with e.g. Grafana.
