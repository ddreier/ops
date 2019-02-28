job "twitchnet-batchstatsprocessor" {
  datacenters = ["dc1"]

  type = "batch"

  parameterized {
  }

  group "statsprocessor" {
    task "statsprocessor" {
      driver = "exec"

      artifact {
        source = "https://s3.us-east-2.amazonaws.com/SUPER SECRET/twitchnet/StatsProcessor.zip"
        destination = "local/twitchnet"
      }

      env {
        StatsdIP = "192.168.0.0"
        RabbitMQ__Username = "SUPER SECRET"
        RabbitMQ__Password = "SUPER SECRET"
        RabbitMQ__VirtualHost = "/"
        RabbitMQ__Hostname = "192.168.0.0"
      }

      config {
        command = "local/twitchnet/TwitchNet.Applications.StatsProcessor"
      }

      resources {
        cpu = 75
        memory = 64
      }

      service {
        name = "${JOB}"
        tags = [ "statsprocessor"]
      }
    }
  }
}