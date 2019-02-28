data_dir = "/var/lib/nomad"

server {
  enabled = true

  bootstrap_expect = 3
  server_join {
    retry_join = [ "provider=aws access_key_id=SUPER SECRET secret_access_key=SUPER SECRET tag_key=nomad-join tag_value=nomad-join" ]
  }
}
