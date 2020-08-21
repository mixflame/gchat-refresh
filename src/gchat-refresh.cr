require "http/client"
require "socket"

module Gchat::Refresh
  VERSION = "0.1.0"

  response = HTTP::Client.get "https://wonderful-heyrovsky-0c77d0.netlify.app/.netlify/functions/msl"

  puts response.body

  servers = response.body.split("\n")

  servers.each do |server|
    info = server.split("::!!::")
    ip = info[2]
    port = info[3].to_i
    puts "refreshing #{ip}:#{port}"
    client = TCPSocket.new(ip, port)
    client << "REFRESH\0"
    response = client.gets
    puts response
    client.close
  end
end
