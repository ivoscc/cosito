require "cuba"

require "cuba/render"


Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on root do
      res.write render("home.erb", content: "hello, world")
    end
  end
end
