require "cuba"

Cuba.use Rack::Session::Cookie,
  secret: "__a_very_long_string__"

Cuba.define do
  on get do
    on root do
      res.write "ollanta in the house"
    end
  end
end
