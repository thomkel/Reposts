require 'json'
require 'rest-client'

class RedditPostParserController < ApplicationController

	# purpose: get reddit submissions. parse to submit to kafka queue.

	# need to know:
		# last reddit submission parsed-- stores ids, date in database
		# 

	def initialize
		# last_submission_parsed = Submission.all.sort_by('DESC').first
		count = 0
		after = nil

		# if last_submission_parsed.date_parsed > # designated time period (2 days???)
		url = "https://www.reddit.com/new.json?limit=100"
		json = open(url).read
		json_data = JSON.parse(json)
		posts = json_data["data"]["children"]

		@reposts = get_reposts(posts)

		#end
	end

	def get_reposts(posts)
		urls = get_urls(posts)
		url = urls.first.tr('"','')

		@responses = []

		# urls.each do |url|
			url = "http://karmadecay.com/index"

	RestClient.post(url, :url => 'http://i.imgur.com/aoJvyVO.jpg') do |response, request, result, &block|
	  if [301, 302, 307].include? response.code
	    @redirect_url = response.headers[:location]
	  else
	    @response = response.return!(request, result, &block)
	  end
	end

	@response = RestClient.get "http://karmadecay.com/#{@redirect_url}"
			# @responses.push(response.read)
		# end

	end

	def get_urls(posts)
		urls = []

		posts.each do |post|
			url = post["data"]["url"]

			if url.include? "imgur"  # may want to change to search for file type substring
				urls.push(url)
			end
		end

		return urls
	end

end
