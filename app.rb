require "json"
require "cuba"

require "cuba/render"

Cuba.plugin Cuba::Render
Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

Cuba.use Rack::Static,
  root: "public",
  urls: ["/js", "/css", "/less", "/img"]

Cuba.plugin Cuba::Render
$data = [
    "Noticia 1",
    "Noticia 2",
    "Noticia 3",
    "Noticia 4",
    "Noticia 5",
]
$JSON_NAME = "data.json"

def read_json_news( filename )
    JSON.parse(IO.read(filename))
end

def get_random_new()
    r = Random.new
    json_data = read_json_news($JSON_NAME)
    r_number = r.rand(0..json_data.length-1)
    json_data["data"][r_number]
end

Cuba.define do
  on get do
    on root do
      res.write render("home.erb", trivia:get_random_new() )
    end

    on "get_data" do
        res.write JSON.generate(get_random_new())
    end
  end
end
