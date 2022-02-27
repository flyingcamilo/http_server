require 'socket'

server  = TCPServer.new('0.0.0.0', 80)

loop {
  client  = server.accept
  request = client.readpartial(2048)
  
  method, path, version = request.lines[0].split

  puts "#{method} #{path} #{version}"

  headers = "HTTP/1.1 200 OK\r\nDate: #{Time.now}\r\nContent-Type: text/html; charset=iso-8859-1\r\n\r\n"
  client.puts headers

  if path == "/healthcheck"
    client.write("OK")
  else
    client.write("Well, hello there!")
  end

  client.close
}
