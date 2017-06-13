namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
  	# 1. Schedule Sunday at 5pm (Waits until Deployment)
  	# 2. Iterate over all employees
  	# 3. Skip AdminUsers
  	# 4. Send a message that has instructions and a link to log time

  	# No spaces or dashes
  	# exactly 10 characters
  	# all charactrs have to be a number
  	
  end

end
