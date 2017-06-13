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

  desc "Sends mail notifications to managers (admin users) each day to inform of pending overtime requests"
  task manager_email: :environment do
    #1. Iterate over the list of pending overtime requests
    #2. Check to see if there are any requests
    #3. Iterate over the list of admin users/managers
    #4. Send the email to each admin
    submitted_posts = Post.submitted
    admin_users = AdminUser.all
    if submitted_posts.count > 0 
      admin_useres.each do |admin|
        ManagerMailer.email(admin).deliver_later
      end 
    end
  end

end
