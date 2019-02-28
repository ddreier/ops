bind_addr = "127.0.0.1"
data_dir  = "/var/lib/nomad"

advertise {
  # Defaults to the first private IP address.
  http = "0.0.0.0"
  rpc  = "0.0.0.0"
  serf = "0.0.0.0"
}

client {
  enabled = true
  servers = ["192.168.0.0"]
  options {
    "driver.raw_exec.enable" = "1"
  }
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  datadog_address = "127.0.0.1:8125"
  statsd_address = "192.168.0.0:8125"
  disable_hostname = true
}
