defmodule Exit do
  use Application

# ====================================================================
#  Application callbacks
# ====================================================================
  def start(_type, _args) do
    pid = spawn(Exit, :start_counter, [])
    {:ok, pid}
  end

  def stop(pid) do
    send pid, :stop
  end


# ====================================================================
#  Internal functions
# ====================================================================
  def start_counter() do
    # STEP 1: define a Metric
    metricId = [:my_counter]  # the exometer ID of the metric, a list of atoms
    metricType = :counter     # which kind of metric?
    metricOptions = []        # possible options?
    :exometer.new(metricId, metricType, metricOptions)
    # the counter is set to 0 by default.

    # STEP 2: subscribe the metric reporter to the metric such that metrics are
    # sent to some aggregator, e.g. InfluxDB.
    reporters = :exometer_report.list_reporters()
    for {reporter, _pid} <- reporters do
      subscribe_to_counter(reporter, metricId)
    end

    # start incrementing the counter
    send_random_reset
    incr_each_sec(metricId)
  end

  defp subscribe_to_counter(reporter, metricId) do
    reportInterval = 1000                    # reporting interval in ms
    datapoints = [:value, :ms_since_reset]   # datapoints we are subscribing to
    reportOptions = []                       # possible options?
    :ok = :exometer_report.subscribe(reporter, metricId, datapoints, reportInterval, reportOptions)
  end

  # Increment the counter each second and randomly reset counter to 0
  defp incr_each_sec(metricId) do
    receive do
      :stop -> :ok
      :reset ->
        send_random_reset
        IO.puts "Resetting counter ..."
        :exometer.reset(metricId)
        incr_each_sec(metricId)
    after 1000 ->
      {:ok, value} = :exometer.get_value(metricId)
      IO.puts "Counter Status: #{inspect value}"
      :exometer.update(metricId, 1)
      incr_each_sec(metricId)
    end
  end

  # Sends reset somewhen in the next minute.
  defp send_random_reset() do
    nextReset = :random.uniform(60000)
    send_after(nextReset, self(), :reset)
  end

  # Separate process waits <time> msec, then sends <msg> to <pid>.
  defp send_after(time, pid, msg) do
    spawn(fn -> receive do after time -> send(pid, msg) end end)
  end
end
