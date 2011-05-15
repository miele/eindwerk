class Video < ActiveRecord::Base

auto_html_for :body do
    html_escape
    youtube(:width => 400, :height => 250)
    vimeo(:width => 400, :height => 250)
    simple_format
  end

end
