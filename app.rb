#Made by David Shechtman, used a lot of formatting from zillabyte docs
#Version 1.6
require 'zillabyte'
require 'nokogiri'
require 'open-uri'

app = Zillabyte.app("request_a_demo")
  .source("select * from web_pages")
  .each {|tuple|

	#Get the fields from your input data.
    	url = tuple['url']
   	 html = tuple['html']
	 title = ""
	#email input = "not found"
	
      #grab a bunch of urls, some of which are not exactly what we are looking for(fuzzy filter)
	if (url.to_s.include?('request-demo')|| url.to_s.include?('request-a-demo')||url.to_s.include?('demo'))  
	#check the document for the title 
  	     	doc = Nokogiri::HTML((html))
		title =doc.css("title")[0].text
	#	if(some condition)
	#	email= "input field found"
	#	end 		 		
          emit :url => url, :title => title 
      end
   

  }
  .sink{
    name "request_a_demo"
    column "url", :string
    column "title", :string
  #  column "email-input", :string
  }
