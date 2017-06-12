module SmsTool
	account_sid = ENV['TWILIO_ACCOUNT_SID']
	auth_token = ENV['TWILIO_AUTH_TOKE']

	@client = Twilio::REST::Client.new account_sid, auth_token

	def self.send_sms(num:, msg:)
		@client.messages.create(
			from: ENV['TWILIO_PHONE_NUMBER'],
			to: "+1#{num}",
			body: "#{msg}"
		)

	 	puts "Sending SMS..."
	 	puts "#{msg} to #{num}"
	end
end