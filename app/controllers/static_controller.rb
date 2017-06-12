class StaticController < ApplicationController
	def homepage
		if admin_types.include?(current_user.type)
			@recent_audit_items = AuditLog.last(10)
			@pending_approvals = Post.submitted
		else
		end
	end
end