require 'socket'

server  = TCPServer.new('0.0.0.0', 80)
$stdout.sync = true

loop {
  client  = server.accept
  request = client.readpartial(2048)
  
  method, path, version = request.lines[0].split
  STDOUT.puts "#{method} #{path} #{version}"

  if path == "/healthcheck" 
    response = "OK"
  else
    response = "Well, hello there!"
  end

  headers = "HTTP/1.1 200 OK\r\nDate: #{Time.now}\r\nContent-Length: #{response.bytesize}\r\nContent-Type: text/html; charset=iso-8859-1\r\n\r\n"
  client.puts headers
  client.puts response

  client.close
}
