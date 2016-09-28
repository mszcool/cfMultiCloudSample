require "sinatra/base"
require "json"

class Web < Sinatra::Base

  get "/" do
    raise "Please define environment variable 'REGION' with the cloud region you're running in!" unless ENV.has_key?("REGION")

    region = ENV.fetch("REGION")
    instance = ENV.fetch("CF_INSTANCE_INDEX", 0)
    addr = ENV.fetch("CF_INSTANCE_ADDR", "127.0.0.1")

    %{
      <h1>I am running in #{region}</h1>
      <hr />
      <h2>I am app instance #{instance}</h2>
      <h2>I am running at #{addr}</h2>
      <hr />
    }
  end

  get "/env.json" do
    content_type "application/json"
    JSON.pretty_generate(ENV.to_h)
  end

end

run Web.new
