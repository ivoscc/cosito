require "json"
require "cuba"

require "cuba/render"

Cuba.plugin Cuba::Render
Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

Cuba.use Rack::Static,
  root: "public",
  urls: ["/js", "/css", "/less", "/img"]

$JSON_NAME = "data.json"

def read_json_news( filename )
    begin
        JSON.parse(IO.read(filename))
    rescue => _
        {
            "data" => [{
                "title" =>  "",
                "url" => ""
            }],
            "phrase" => []
        }
    end
end

def get_random_new()
    r = Random.new
    json_data = read_json_news($JSON_NAME)
    puts json_data
    data_top = json_data["data"].length-1
    phrase_top = json_data["phrases"].length-1
    if data_top < 0
        data_top = 0
    end
    if phrase_top < 0
        phrase_top = 0
    end
    data = json_data["data"][r.rand(0..data_top)]
    phrase = json_data["phrases"][r.rand(0..phrase_top)]
    {'phrase' => phrase, 'title' => data['title'], 'url'=> data['url']}
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

