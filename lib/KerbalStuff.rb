require 'net/http'
require 'json'
require 'uri'

module KerbalStuff

	api_url = "https://kerbalstuff.com/api"
	search_mod = "https://kerbalstuff.com/api/search/mod?query="
	search_user = "https://kerbalstuff.com/api/search/user?query="
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
	
	# Searches for mods with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Hash] A parsed JSON output containing the mods which were found.
	def self.search_mod(query)
		response = get_https_response("#{search_mod}#{query}")
		JSON.parse(response.body)
	end
	
	# Searches for users with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Hash] A parsed JSON output containing the users which were found.
	def self.search_user(query)
		response = get_https_response("#{search_user}#{query}")
		JSON.parse(response.body)
	end
	
	# Retrieves information about the specified user.
	#
	# @param username [String] the username to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the user.
	def self.user(username)
		raise "username cannot be nil" unless username.length > 0
		
		response = get_https_response("#{user_url}#{username}")
		JSON.parse(response.body)
	end

	# Retrieves the information about the specified mod.
	#
	# @param id [Fixnum] the id to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the mod.
	def self.mod(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{mod_url}#{id}")
		JSON.parse(response.body)
	end
	
	# Retrieves the information about the last released version of the specified mod.
	#
	# @param username [Fixnum] the id to retrieve information of its latest version released.
	# @return [Hash] A parsed JSON output containing the information about the latest version released.
	def self.get_latest_version(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{mod}#{id}/latest")
		JSON.parse(response.body)
	end
	
	# Retrieves basic mod information - name, author, description, how many times it was downloaded, url to the mod and latest version.
	#
	# @param id [Fixnum] The id of the mod to retrieve information for.
	# @return [Hash] A hash containing basic mod info.
	def self.get_basic_mod_info(id)
		oldHash = mod(id)
		
		modHash = Hash.new()
		modHash["name"] = oldHash["name"]
		modHash["author"] = oldHash["author"]
		modHash["description"] = oldHash["short_description"]
		modHash["downloads"] = oldHash["downloads"]
		modHash["url"] = "https://kerbalstuff.com/mod/#{id}/}"
		modHash["latest_version"] = oldHash["versions"][0]["friendly_version"]
		
		modHash
	end
	
	# Retrieves basic user info - username, mods, irc nick and forum username.
	#
	# @param username [String] The user to gather information for.
	# @return [Hash] A hash containing the basic user info.
	def self.get_basic_user_info(string)
		oldHash = user(string)
		
		userHash = Hash.new()
		userHash["username"] = oldHash["username"]
		userHash["mods"] = oldHash["mods"]
		userHash["ircNick"] = oldHash["ircNick"]
		userHash["forumusername"] = oldHash["forumusername"]
		
		userHash
	end
	
end