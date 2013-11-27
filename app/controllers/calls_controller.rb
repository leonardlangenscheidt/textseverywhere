class CallsController < ApplicationController
	def create
		user = User.find(params[:user_id])

		account_sid = ENV['TWILIO_ACCOUNT_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		# binding.pry
		@client = Twilio::REST::Client.new(account_sid, auth_token)

		send_call = @client.account.calls.create(
			from: '+19739434297',
			to: user.number,
			url: "http://twimlets.com/conference?Message=Hey%20Yo%20welcome%20to%20Lenny's%20Kick%20Ass%20Web%20Chat.%20Also%20Adam%20will%20be%20here%20kicking%20further%20ass.&Music=soft-rock"
		)

		if send_call
			flash[:notice] = "Nice, dude. #{user.name} was invited to hang!"
			redirect_to users_path
		else
			flash[:notice] = "That didn't work at all!"
			redirect_to user_path(user)
		end
	end
end
