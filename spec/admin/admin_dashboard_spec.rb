require 'rails_helper'

RSpec.feature "admin dashboard" do 
	scenario "can be reached successfully" do 
		visit admin_root_path
		expect(page.status_code).to eq(200)
	end

	scenario "it does not allow users to access without being signed in" do 
		visit admin_root_path
		expect(page.current_path).to eq(new_user_session_path)
	end

	scenario "cannot be reached by a non-admin user" do 
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)

		visit admin_root_path

		expect(current_path).to eq(root_path)
	end

	scenario "can be reached by a non-admin user" do 
		admin_user = FactoryGirl.create(:admin_user)
		login_as(admin_user, :scope => :admin_user)

		visit admin_root_path

		expect(page.status_code).to eq(200)
	end
end

__END__

For some reason it was necessary to use RSpec and not context/describe/it