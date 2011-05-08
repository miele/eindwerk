module ApplicationHelper



 def display_content_with_links(tweet)
    tweet.content.gsub(/(http:\/\/[a-zA-Z0-9\/\.\+\-_:?&=]+)/) {|a| "<a href=\"#{a}\">#{a}</a>"}
  end
  
  def sortable(column,title = nil)
   title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
  end
  
  
  def facebook_like
content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=true&width=450&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
          end
           
def pdf_image_tag(image, options = {})
options[:src] = File.expand_path("#{RAILS_ROOT}/public/images/" + image)
tag(:img, options)
end

end
