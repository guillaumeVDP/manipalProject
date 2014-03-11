require 'spec_helper'

describe "FriendlyForwardings" do

  it "devrait rediriger vers la page voulue apres identification" do
    user = Factory(:user)
    visit signin_path
    # Le test suit automatiquement la redirection vers la page d'identification.
    fill_in :email,    :with => user.email
    fill_in "Mot de passe", :with => user.password
    click_button
    # Le test suit à nouveau la redirection, cette fois vers users/edit.
    response.should render_template("users/show")
  end
end