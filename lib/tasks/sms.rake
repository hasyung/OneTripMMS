namespace :sms do
  desc "receive sms and send mms"
  task :receive => :environment do
    Place.receive_sms
  end
end