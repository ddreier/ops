data_dir = "/var/lib/nomad"

client {
  enabled = true

  server_join {
    retry_join = [ "provider=aws access_key_id=SUPER SECRET secret_access_key=SUPER SECRET tag_key=nomad-join tag_value=nomad-join" ]
  }

  options {
    "driver.raw_exec.enable" = "1"
  }
}
