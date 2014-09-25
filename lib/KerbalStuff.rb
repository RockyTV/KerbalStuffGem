require 'net/http'
require 'json'
require 'uri'

module KerbalStuff

	api_url = "https://kerbalstuff.com/api"
	user_url = "https://kerbalstuff.com/api/user/"
	mod_url = "https://kerbalstuff.com/api/mod/"
	
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
		end
	end
	
	# Searches for mods with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Hash] A parsed JSON output containing the mods which were found. Will return a [String] if no results were found.
	def self.search_mod(query)
		res = get_json("https://kerbalstuff.com/api/search/mod?query=#{query}")
		
		if res.length == 0
			return "No results were found for '#{query}'."
		else
			return res
		end
	end
	
	# Searches for users with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Hash] A parsed JSON output containing the users which were found. Will return a [String] if no results were found.
	def self.search_user(query)
		res = get_json("https://kerbalstuff.com/api/search/user?query=#{query}")
		
		if res.length == 0
			return "No results were found for '#{query}'."
		else
			return res
		end
	end
	
	# Retrieves information about the specified user.
	#
	# @param username [String] the username to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the user. Will return a [String] if no users were found.
	def self.user(username)
		raise "username cannot be nil" unless username.length > 0
		
		res = get_json("https://kerbalstuff.com/api/user/#{username}")
		
		if res.include? 'error'
			return res[1]
		else
			return res
		end
	end

	# Retrieves the information about the specified mod.
	#
	# @param id [Fixnum] the id to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the mod. Will return a [String] if no mods were found.
	def self.mod(id)
		raise "id cannot be nil" unless id.is_a?(Integer)
		
		res = get_json("https://kerbalstuff.com/api/mod/#{id}")
		
		if res.include? 'error'
			return res[1]
		else
			return res
		end
	end
	
	# Retrieves the information about the last released version of the specified mod.
	#
	# @param username [Fixnum] the id to retrieve information of its latest version released.
	# @return [Hash] A parsed JSON output containing the information about the latest version released.
	def self.get_latest_version(id)
		raise "id cannot be nil" unless id.is_a?(Integer)
		
		res = get_json("https://kerbalstuff.com/api/mod/#{id}/latest")
		
		if res.include? 'error'
			return res[1]
		else
			return res
		end
	end
	
	# Retrieves basic mod information - name, author, description, how many times it was downloaded, url to the mod and latest version.
	#
	# @param id [Fixnum] The id of the mod to retrieve information for.
	# @return [Hash] A hash containing basic mod info.
	def self.get_basic_mod_info(id)
		oldHash = mod(id)
		
		if oldHash.is_a?(String)
			return oldHash
		else
			modHash = Hash.new()
			modHash["name"] = oldHash["name"]
			modHash["author"] = oldHash["author"]
			modHash["description"] = oldHash["short_description"]
			modHash["downloads"] = oldHash["downloads"]
			modHash["url"] = "https://kerbalstuff.com/mod/#{id}/}"
			modHash["latest_version"] = oldHash["versions"][0]["friendly_version"]
			
			return modHash
		end
	end
	
	# Retrieves basic user info - username, mods, irc nick and forum username.
	#
	# @param username [String] The user to gather information for.
	# @return [Hash] A hash containing the basic user info.
	def self.get_basic_user_info(username)
		oldHash = user(username)
		
		if oldHash.is_a?(String)
			return oldHash
		else
			userHash = Hash.new()
			userHash["username"] = oldHash["username"]
			userHash["mods"] = oldHash["mods"]
			userHash["ircNick"] = oldHash["ircNick"]
			userHash["forumusername"] = oldHash["forumusername"]
		
			return userHash
		end
	end
	
end