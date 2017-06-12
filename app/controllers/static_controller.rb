class StaticController < ApplicationController
	def homepage
		if admin_types.include?(current_user.type)
			@recent_audit_items = AuditLog.last(10)
			@pending_approvals = Post.submitted
		else
			@pending_audit_confirmations = current_user.audit_logs
		end
	end
end