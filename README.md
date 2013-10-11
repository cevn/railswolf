README
---

To test JSON using a script: 

    python3 postrequest.py
    ./postrequest.sh

The python script is easier to modify. Make sure you use https or rails will 
not authenticate properly or something. 

The response will be saved in a `response.json` object which is a list of errors. 
If the array is empty, you should have successfully created a user. 

To run the server on your current computer: 
You need ruby, rails, and a postgresql server(with a superuser and database
named `$user`)  running on your computer. 

    git clone https://github.com/cevn/railswolf.git
    cd railswolf
    rake db:reset
    rails s

When setting up on a new computer, you may get a `PG:BadConnect` exception if
you don't have a postgresql server correctly set up on your computer. 

Also, make sure that `pg_hba.conf` looks like this so that the app can be run (the important part is
that the connections are set to `trust` instead of `all`). WARNING: do not do
this on a production server. This sets it so that localhost can connect to the
postgres server without authentication. 

    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    # "local" is for Unix domain socket connections only
    local   all             all                                     trust
    # IPv4 local connections:
    host    all             all             127.0.0.1/32            trust
    # IPv6 local connections:
    host    all             all             ::1/128                 trust

After this, the app should properly work, after running `rake db:reset` in the app directory. 
