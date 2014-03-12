namespace :db do
  desc "Peupler la base de donnees"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    admin = User.create!(:nom => "Tapotigner",
                 :email => "xoinf@hotmail.fr",
                 :password => "rgjlvdp",
                 :password_confirmation => "rgjlvdp")
    admin.toggle!(:admin)
    99.times do |n|
      nom  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "motdepasse"
      User.create!(:nom => nom,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end