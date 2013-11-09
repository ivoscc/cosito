require "cuba"

require "cuba/render"


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

def get_random_new()
    r = Random.new
    $data[r.rand(0..$data.length-1)]
end

Cuba.define do
  on get do
    on root do
      res.write render("home.erb", content: "hello, world")
    end

    on "get_data" do
        res.write get_random_new()
    end

    on "css", extension("css") do |file|
      res.write "Filename: #{file}" #=> "Filename: basic"
    end

  end
end
