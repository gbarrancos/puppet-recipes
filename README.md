# puppet-recipes

This project contains the following recipes:

* cache.pp - Redis Server configured to be used as a LRU cache
* webapp.pp - A Rack Ruby application deployed with Nginx+Passenger
* webstatic.pp - A Static Nginx Installation 

## Running

From inside the project folder invoke puppet as follows:

     puppet apply --modulepath ./modules manifests/cache.pp

