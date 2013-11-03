import urllib.request
import json
import sys

# Edit these parameters for user creation. 

fullname = "John Doe"
email    = "example3@example.com" 
password = "example" 


url = "https://railswolf.herokuapp.com/sessions"  
                                    # Change the string if you're going to use a different url. 
                                    # Testing with heroku: https://railswolf.herokuapp.com/users
                                    # Testing with localhost: https://localhost:3000/users
                                    # Testing with pow configured: https://railswolf.dev/users

if (len(sys.argv) == 2): 
    url = "https://" + sys.argv[1]   


json_dict = { 'user': { 'email': email, 'password': password }}

# convert json_dict to JSON
json_data = json.dumps(json_dict)

# convert str to bytes (ensure encoding is OK)
post_data = json_data.encode('utf-8')

# we should also say the JSON content type header
headers = {}
headers['Content-Type'] = 'application/json'
headers['Accept']       = 'application/json'

# now do the request for a url
req = urllib.request.Request(url, post_data, headers)

# send the request
res = urllib.request.urlopen(req)

file_name = 'response.json' 
local_file = open(file_name, "wb")
#Write to our local file
local_file.write(res.read())
local_file.close()
