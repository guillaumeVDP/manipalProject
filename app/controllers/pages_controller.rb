class PagesController < ApplicationController
  def home
    @title = "Home"
    @subtitle = "Welcome to my website"
  end

  def contact
  	@title = "Contact me"
    @subtitle = "Contact"
  end

  def about
  	@title = "About"
    @subtitle = "About this website"
  end

  def skills
    @title = "Skills"
    @subtitle = "My Skills"
  end

  def lifestyle
    @title = "LifeStyle"
    @subtitle = "My LifeStyle"
  end

  def cv
    @title = "Curriculum Vitae"
    @subtitle = "Curriculum Vitae"
  end
end
