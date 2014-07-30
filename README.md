docker-rails
============

__Docker image for running Ruby on Rails applications__

docker-rails is based on a minimal ubuntu 14.04 distribution.  
There is 'rails' user with passwordless sudo capability.  
There is ruby 2.1.2 installed via rbenv with bundler gem installed.  
There is sshd running on port 22, so you can ssh to a running container (so you can deploy your application using Capistrano).

To run a container:  
`$ docker run --name rails -d -p 10022:22 cthulhu666/docker-rails`

To ssh to a running container first check for generated password in container logs:  

    $ docker logs rails
  
    User: rails Password: your-password-here
      * Starting OpenBSD Secure Shell server sshd
        ...done.

Now you can ssh:

    $ ssh -p 10022 rails@localhost
    
Take a look around:

    rails@ca7ead03afb8:~$ ruby -v
    ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-linux]

    
