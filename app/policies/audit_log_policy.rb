class AuditLogPolicy < ApplicationPolicy
	def index?
		#TODO: REFRACTOR
		return true if admin?
		false
	end

	def confirm?
	 record.user.id == user.id
	end

	private

	def admin?
		admin_types.include?(user.type)
	end

end