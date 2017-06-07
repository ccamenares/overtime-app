require 'rails_helper'

describe 'navigate' do
	before do 
			@user = FactoryGirl.create(:user)
			@post = FactoryGirl.create(:post)
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
			expect(page).to have_content(/Rationale|content/)
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
			fill_in 'post[rationale]', with: "Some rationale"
			click_on "Save"

			expect(page).to have_content("Some rationale")
		end

		it 'will have a user associated with it' do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "User_Association"
			click_on "Save"

			expect(@user.posts.last.rationale).to eq ("User_Association")
		end
	end

	describe 'edit' do 
		it 'can be edited' do 
			visit posts_path
			click_link("edit_#{@post.id}")

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "Edited Content"
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