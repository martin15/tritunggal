class ContactUsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = 'Message was successfully sent.'
      redirect_to contact_us_path
    else
      flash[:error] = "Message failed to send"
      render :action => :index
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :content)
    end
end
