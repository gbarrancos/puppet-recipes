app = proc do |env|
req = Rack::Request.new(env)	
[200, {"Content-Type" => "text/html"}, ["<html><body><h1>Hello Chaordic from port #{req.port}!</h1><h3>Request info:</h3><p><code>#{env.inspect}</code></p></body></html>"]]
end
run app
