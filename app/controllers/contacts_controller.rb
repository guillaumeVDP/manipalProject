class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      redirect_to root_path
      flash[:success] = 'Thank you for your message. I will contact you soon!'
    else
      redirect_to root_path
      flash[:error] = 'Cannot send message.'
    end
  end
end