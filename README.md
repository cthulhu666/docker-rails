docker-rails
============

__Docker image for running Ruby on Rails applications in production__

docker-rails is based on a debian jessie.  
There is 'ruby' user with passwordless sudo capability.  
There is ruby 2.1.2 installed via rbenv with bundler gem installed.  

This image is meant as a base image; you need to dockerize your app first.
Create Dockerfile inside your app source dir:

    FROM cthulhu666/docker-rails
    ADD . /app
    RUN sudo chown -R ruby:ruby /app
    WORKDIR /app
    RUN bundle install --without development test --deployment --quiet
    EXPOSE 3000
    
Docker-rails expects your application to have a Procfile, so create one, e.g.:

    unicorn: bundle exec unicorn -E production
    sidekiq: bundle exec sidekiq -e production
 
Build your docker image:

    docker build -t [your_app_name] .

Run a container:  
    
    $ docker run --name rails -d -p 8080:8080 -v [host_shared_dir]:/home/rails/shared [your_app_name] app:start

You can find your application logs in [host_shared_dir]/logs
