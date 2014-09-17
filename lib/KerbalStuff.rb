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
		@url = URI.parse(url)
		http = Net::HTTP.new(@url.host, @url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		
		request = Net::HTTP::Get.new(@url.request_uri)
		
		response = http.request(request)
		response
	end
	
	def self.SearchMod(query)
		response = get_https_response("#{SEARCH_MOD}#{query}")
		JSON.parse(response.body)
	end
	
	def self.SearchUser(query)
		response = get_https_response("#{SEARCH_USER}#{query}")
		JSON.parse(response.body)
	end
	
	def self.User(username)
		raise "username cannot be nil" unless username.length > 0
		
		response = get_https_response("#{USER}#{username}")
		JSON.parse(response.body)
	end

	def self.Mod(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{MOD}#{id}")
		JSON.parse(response.body)
	end
	
	def self.GetLatestVersion(id)
		raise "id cannot be nil" unless id.is_a?(Integer) and id > 0
		
		response = get_https_response("#{MOD}#{id}/latest")
		JSON.parse(response.body)
	end
	
end