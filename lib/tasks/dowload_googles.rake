task :download_googles => :environment do
  Google.sync
end