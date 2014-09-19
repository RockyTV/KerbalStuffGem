require 'net/http'
require 'json'
require 'uri'

module KerbalStuff

	API_URL = "https://kerbalstuff.com/api"
	SEARCH_MOD = "https://kerbalstuff.com/api/search/mod?query="
	SEARCH_USER = "https://kerbalstuff.com/api/search/user?query="
	USER = "https://kerbalstuff.com/api/user/"
	MOD = "https://kerbalstuff.com/api/mod/"
	
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
	def self.SearchMod(query)
		response = get_https_response("#{SEARCH_MOD}#{query}")
		JSON.parse(response.body)
	end
	
	# Searches for users with the specified keyword/phrase.
	#
	# @param query [String] the keyword/phrase to search for.
	# @return [Hash] A parsed JSON output containing the users which were found.
	def self.SearchUser(query)
		response = get_https_response("#{SEARCH_USER}#{query}")
		JSON.parse(response.body)
	end
	
	# Retrieves information about the specified user.
	#
	# @param username [String] the username to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the user.
	def self.User(username)
		raise "username cannot be nil" unless username.length > 0
		
		response = get_https_response("#{USER}#{username}")
		JSON.parse(response.body)
	end

	# Retrieves the information about the specified mod.
	#
	# @param id [Fixnum] the id to retrieve its information.
	# @return [Hash] A parsed JSON output containing the information about the mod.
	def self.Mod(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{MOD}#{id}")
		JSON.parse(response.body)
	end
	
	# Retrieves the information about the slast released version of the specified mod.
	#
	# @param username [Fixnum] the id to retrieve information of its latest version released.
	# @return [Hash] A parsed JSON output containing the information about the latest version released.
	def self.GetLatestVersion(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{MOD}#{id}/latest")
		JSON.parse(response.body)
	end
	
	# Retrieves basic mod information - name, author, description, how many times it was downloaded, url to the mod and latest version.
	#
	# @param id [Fixnum] The id of the mod to retrieve information for.
	# @return [Hash] A hash containing basic mod info.
	def self.GetBasicModInfo(id)
		oldHash = Mod(id)
		
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
	def self.GetBasicUserInfo(string)
		oldHash = User(string)
		
		userHash = Hash.new()
		userHash["username"] = oldHash["username"]
		userHash["mods"] = oldHash["mods"]
		userHash["ircNick"] = oldHash["ircNick"]
		userHash["forumUsername"] = oldHash["forumUsername"]
		
		userHash
	end
	
end