curl -v -H "Accept: application/json" -H "Content-type: application/json"
-X POST -d "{\"user\": {\"name\":\"Sameer
Dhar\",\"email\":\"avielus2@gmail.com\",\"password\":\"asdfasdf\",\"password_confirmation\":\"asdfasdf\"}}"
https://railswolf.herokuapp.com/users -o response.json
