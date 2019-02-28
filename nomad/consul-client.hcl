job "consul" {
  datacenters = ["dc1"]
  type = "system"
  update {
    stagger = "5s"
    max_parallel = 1

  }

  group "consul-agent" {
    task "consul-agent" {
      driver = "exec"
      config {
        command = "local/consul"
        args = [
          "agent",
          "-datacenter=dc1",
          "-server=false",
          "-join=192.168.147.160",
          "-data-dir=local/data",
          "-encrypt=y5DBma9Oprp7BPJG146QbQ=="
        ]
      }

      artifact {
        source = "https://releases.hashicorp.com/consul/1.4.2/consul_1.4.2_linux_amd64.zip"
        options {
          checksum = "sha256:ecdddbc87e7f882c3f9d94e8449865fde553e6f443234a1787414fdacef7af55"
        }
      }

      resources {
        cpu = 500
        memory = 128
        network {
          mbits = 1

          port "server" {
            static = 8300

          }
          port "serf_lan" {
            static = 8301

          }
          port "serf_wan" {
            static = 8302

          }
          port "rpc" {
            static = 8400

          }
          port "http" {
            static = 8500

          }
          port "dns" {
            static = 8600

          }
        }
      }
    }
  }
}