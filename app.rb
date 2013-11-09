require "json"
require "cuba"

require "cuba/render"

Cuba.plugin Cuba::Render
Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

def read_json_news( filename )
    begin
        JSON.parse(IO.read(filename))
    rescue => _
        []
    end
end

Cuba.define do
  on get do
    on root do
      muhlist = read_json_news("data.json")
      res.write render("home.erb", content: "hello, world", muhlist: muhlist)
    end

    on "css", extension("css") do |file|
      res.write "Filename: #{file}" #=> "Filename: basic"
    end

  end
end
