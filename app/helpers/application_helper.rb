module ApplicationHelper
  # Retourner un titre basé sur la page.
  def title
    base_title = "Simple App du Tutoriel Ruby on Rails"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # Get back a logo which redirects to the home page
  def logo
  	logo = image_tag("myLogo.png", :alt => "Application exemple", :class => "round")
  end
end
