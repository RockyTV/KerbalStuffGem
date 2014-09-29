module KerbalStuff
	class User
		
		attr_reader :json
		
		def initialize json
			@json = json
			
			@ircNick = @json['ircNick']
			@mods = []
			@twitterUsername = @json['twitterUsername']
			@username = @json['username']
			@redditUsername = @json['redditUsername']
			@forumUsername = @json['forumUsername']
			@description = @json['description']
			
			if @json['mods'].length > 0
				@json['mods'].each do |mod|
					@mods.push(Mod.new(mod))
				end
			end
		end
		
		def to_s
			"User:\nircNick=#{@ircNick}\nmods=#{@mods}\ntwitterUsername=#{@twitterUsername}\nusername=#{@username}\nredditUsername=#{@redditUsername}\nforumUsername=#{@forumUsername}\ndescription=\"#{@description}\"\n"
		end
		
	end
end