module ApplicationHelper
  # Retourner un titre basé sur la page.
  def title
    base_title = "Guillaume VDP"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def subtitle
    if @subtitle.nil?
      ""
    else
      "#{@subtitle}"
    end
  end

  # Get back a logo which redirects to the home page
  def logo
  	logo = image_tag("myLogo.png", :alt => "myLogo", :class => "round")
  end
end
