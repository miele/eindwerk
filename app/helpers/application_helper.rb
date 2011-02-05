module ApplicationHelper

 def display_content_with_links(tweet)
    tweet.content.gsub(/(http:\/\/[a-zA-Z0-9\/\.\+\-_:?&=]+)/) {|a| "<a href=\"#{a}\">#{a}</a>"}
  end

end
