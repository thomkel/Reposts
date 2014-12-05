require 'json'
require 'open-uri'

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
			@posts = json_data["data"]["children"]
		#end
	end

end
