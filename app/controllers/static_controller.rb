class StaticController < ApplicationController
	def homepage
		@recent_audit_items = AuditLog.last(10)
		@pending_approvals = Post.where(status: 'submitted')
	end
end