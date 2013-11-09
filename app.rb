require "json"
require "cuba"

Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

$JSON_NAME = "data.json"

def read_json_news( filename )
    begin
        JSON.parse(IO.read(filename))
    rescue => _
        [{}]
    end
end

def get_random_new()
    r = Random.new
    json_data = read_json_news($JSON_NAME)
    r_number = r.rand(0..json_data.length-1)
    json_data[r_number]["data"]
end

Cuba.define do
  on get do
    on root do
      res.write "ollanta in the house"
    end

    on "get_data" do
        res.write get_random_new()
    end
  end
end
