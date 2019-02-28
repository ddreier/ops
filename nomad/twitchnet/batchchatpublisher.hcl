job "twitchnet-batchchatpublisher" {
  datacenters = ["dc1"]

  type = "batch"

  parameterized {
    meta_required = [ "STREAMS" ]
  }

  group "chatpublisher" {
    task "chatpublisher" {
      driver = "raw_exec"

      artifact {
        source = "https://s3.us-east-2.amazonaws.com/SUPER SECRET/twitchnet/BatchChatPublisher.zip"
        destination = "local/twitchnet"
      }

      env {
        StreamList = "${NOMAD_META_STREAMS}"
        MessagesToConsole = "true"
        Twitch__Username = "SUPER SECRET"
        Twitch__ClientId = "SUPER SECRET"
        Twitch__AccessToken = "SUPER SECRET"
        RabbitMQ__Username = "SUPER SECRET"
        RabbitMQ__Password = "SUPER SECRET"
        RabbitMQ__VirtualHost = "/"
        RabbitMQ__Hostname = "rabbitmq.service.dc1.consul"
      }

      config {
        command = "local/twitchnet/TwitchNet.Applications.BatchChatPublisher"
      }

      resources {
        cpu = 75
        memory = 100
      }

      service {
        name = "${JOB}"
        tags = [ "chatpublisher"]
      }
    }
  }
}