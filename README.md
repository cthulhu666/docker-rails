docker-rails
============

__Docker image for running Ruby on Rails applications__

docker-rails is based on a minimal ubuntu 14.04 distribution.  
There is 'rails' user with passwordless sudo capability.  
There is ruby 2.1.2 installed via rbenv with bundler gem installed.  

This image is meant as a base image; you need to dockerize your app first.
Create Dockerfile inside your app source dir:

    echo "FROM cthulhu666/docker-rails:latest" > Dockerfile
    
Docker-rails expects your application to have a Procfile, so create one, e.g.:

    unicorn: /home/rails/.rbenv/shims/bundle exec unicorn -E production -c /home/rails/shared/config/unicorn.rb
    sidekiq: /home/rails/.rbenv/shims/bundle exec sidekiq -e production
    
Its is important to use bundle exactly like that: `/home/rails/.rbenv/shims/bundle`.

    
Build your docker image:

    docker build -t [your_app_name] .


Run a container:  
    
    $ docker run --name rails -d -p 8080:8080 -v [host_shared_dir]:/home/rails/shared [your_app_name] app:start

You can find your application logs in [host_shared_dir]/logs
