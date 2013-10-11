import urllib.request
import json

# Edit these parameters for user creation. 

fullname = "John Doe"
email    = "example3@example.com" 
password = "example" 

url = "http://railswolf.herokuapp.com/users"  # This is a local test environment for me only. 
                                    # Change the string if you're going to use a different url. 
                                    # Testing with heroku: http://railswolf.herokuapp.com/users
                                    # Testing with localhost: http://localhost:3000/users

json_dict = { 'user': { 'name': fullname, 'email': email, 'password': password, 'password_confirmation': password }}

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
