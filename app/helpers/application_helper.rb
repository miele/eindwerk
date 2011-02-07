module ApplicationHelper

 def display_content_with_links(tweet)
    tweet.content.gsub(/(http:\/\/[a-zA-Z0-9\/\.\+\-_:?&=]+)/) {|a| "<a href=\"#{a}\">#{a}</a>"}
  end
  
  def sortable(column,title = nil)
   title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
  end

end
