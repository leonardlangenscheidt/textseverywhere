class MessagesController < ApplicationController
	def create
		user = User.find(params[:user_id])
		body = "#{params[:body]}"

		account_sid = ENV['TWILIO_ACCOUNT_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		# binding.pry
		@client = Twilio::REST::Client.new(account_sid, auth_token)

		send_text = @client.account.sms.messages.create(
			from: '+19739434297',
			to: user.number,
			body: body
		)

		if send_text
			flash[:notice] = "Nice, dude. You sent '#{body}' to #{user.number}!"
			redirect_to users_path
		else
			flash[:notice] = "Well that didn't work. Gotta comply!"
			redirect_to user_path(user)
		end
	end
end
