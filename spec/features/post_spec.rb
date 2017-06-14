require 'rails_helper'

describe 'navigate' do
	before do 
			@user = FactoryGirl.create(:user)
			@post = FactoryGirl.create(:post)
			@post.update(user_id: @user.id)
			login_as(@user)
	end
	describe 'index' do 
		before do 
			visit posts_path
		end
		it 'can be reached successfully' do 
			expect(page.status_code).to eq (200)
		end

		it 'has a title of Posts' do 
			expect(page).to have_content(/Posts/) 
		end

		it 'has a list of posts' do 
			post2 = FactoryGirl.create(:second_post)
			visit posts_path
			expect(page).to have_content(/work_performed|content/)
		end

		it 'has a scope so that only owners or admins can see thier posts' do 
			post1 = Post.create(date: Date.today, work_performed: "Hello", user_id: @user.id, daily_hours: 3.5)
			post2 = Post.create(date: Date.today, work_performed: "Hello", user_id: @user.id, daily_hours: 3.5)			
			other_user = User.create(first_name: "Non", last_name: "Authorized", email: "non@authorized.com", password: "password", password_confirmation: "password", phone: "5555555555")
			post_from_other_user = Post.create(date: Date.today, work_performed: "This post shouldn't be seen", user_id: other_user.id, daily_hours: 3.5)
			visit posts_path

			expect(page).not_to have_content(/This post shouldn't be seen/)
		end
	end

	describe 'new' do 
		it 'has a link from the homepage' do 
			visit root_path 
			click_link("new_post_from_nav")
			expect(page.status_code).to eq(200)
		end
	end

	describe 'delete' do 
		it 'can be deleted' do 
			visit posts_path

			click_link("delete_post_#{@post.id}_from_index")
			expect(page.status_code).to eq(200)
		end
	end

	describe 'creation' do 
		before do 
			visit new_post_path
		end
		it 'has a form that can be reached' do 
			expect(page.status_code).to eq(200)
		end

		it 'can be created from new form page' do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[work_performed]', with: "Some work_performed"
			fill_in 'post[daily_hours]', with: 4.5

			expect { click_on "Save" }.to change(Post, :count).by(1)
		end

		it 'will have a user associated with it' do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[work_performed]', with: "User_Association"
			fill_in 'post[daily_hours]', with: 4.5
			click_on "Save"

			expect(@user.posts.last.work_performed).to eq ("User_Association")
		end
	end

	describe 'edit' do 
		it 'can be edited' do 
			visit posts_path
			click_link("edit_#{@post.id}")

			fill_in 'post[date]', with: Date.today
			fill_in 'post[work_performed]', with: "Edited Content"
			click_on "Save"

			expect(page).to have_content("Edited Content")
		end

		it 'cannot be edited by a non authorized user' do 
			logout(:user)
			non_authorized_user = FactoryGirl.create(:non_authorized_user)
			login_as(non_authorized_user, :scope => :user)

			visit edit_post_path(@post)

			expect(current_path).to eq(root_path)
		end
	end
end