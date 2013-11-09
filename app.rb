require "cuba"

Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

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
      res.write "ollanta in the house"
    end

    on "get_data" do
        res.write get_random_new()
    end
  end
end
