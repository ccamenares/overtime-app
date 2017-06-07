class PostPolicy < ApplicationPolicy
	def update?
		#Case 1 = User of Record
		record.user_id == user.id || admin_types.include?(current_user.type)
		#Case 2 = Admin user

	end
end