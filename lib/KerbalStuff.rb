require 'net/http'
require 'json'
require 'uri'

module KerbalStuff

	autoload :VERSION, 'kerbalstuff/version'
	autoload :Mod, 'kerbalstuff/mod'
	autoload :ModVerison, 'kerbalstuff/mod'
	autoload :User, 'kerbalstuff/user'

	def self.get_https_response(url)
		@url = URI.parse(URI.escape(url))
		http = Net::HTTP.new(@url.host, @url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		
		request = Net::HTTP::Get.new(@url.request_uri)
		
		response = http.request(request)
		response
	end
	
	def self.get_json(url)
		response = get_https_response(url)
		json = JSON.parse(response.body)
		
		if json.is_a?(Hash)
			if json.has_key? 'error'
				return "error", "#{json['reason']}"
			else
				return json
			end
		else
			return json
		end
	end
	
	# Searches for mods with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Array] An array containing the results found. If no result was found, will return a String.
	def self.search_mod(query)
		res = get_json("https://kerbalstuff.com/api/search/mod?query=#{query}")
		
		resArr = []
		
		if res.length == 0
			return "No results were found for '#{query}'."
		else
			res.each do |mod|
				resArr.push(Mod.new(mod))
			end
			return resArr
		end
	end
	
	# Searches for users with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Array] An array containing the results found. If no result was found, will return a String.
	def self.search_user(query)
		res = get_json("https://kerbalstuff.com/api/search/user?query=#{query}")
		
		resArr = []
		
		if res.length == 0
			return "No results were found for '#{query}'."
		else
			res.each do |user|
				resArr.push(User.new(user))
			end
			return resArr
		end
	end
	
	# Retrieves the specified mod information.
	#
	# @param id [Integer] the id of the mod to retrieve information for.
	# @return [Mod] A Mod object containing the information about the mod.
	def self.get_mod(id)
		raise "id must be an Integer" unless id.is_a?(Integer)
		
		return Mod.new(get_json("https://kerbalstuff.com/api/mod/#{id}"))
	end
	
	# Retrieves the specified user information.
	#
	# @param username [String] the username of the user to retrieve information for.
	# @return [User] A User object containing the information about the user.
	def self.get_user(username)
		raise "username must be a String" unless username.is_a?(String)
		raise "username cannot be an empty string" unless username.length > 0
		
		return User.new(get_json("https://kerbalstuff.com/api/user/#{username}"))
	end
	
	# Retrieves the latest version of the specified mod.
	#
	# @param id [Integer] the id of the mod to retrieve the latest version released.
	# @return [ModVersion] A ModVersion object containing information about the version.
	def self.get_latest_mod_version(id)
		raise "id must be an Integer" unless id.is_a?(Integer)
		
		return ModVersion.new(get_json("https://kerbalstuff.com/api/mod/#{id}/latest"))
	end
	
end