# docker-php7-env
PHP 7 with FPM and Xdebug, Redis, Mysql and Nginx Docker containers
This project intend to be a set of Docker containers that can to be used to develop a Symfony Application (Can be modified for other PHP frameworks) with PHP 7 with PHP-FPM and Xdebug, Redis, Mysql, and Nginx.

First you need (obviously) Docker installed in your machine.
If you use OS X you will need Dinghy too for avoid folder permissions problems.

1.- Clone this repo to your machine.
2.- Run `docker-machine ip default` for know the Docker Machine IP. Note: Run `dinghy ip`in case that you are using Dinghy instead.  
3.- Edit your `/etc/hosts/` and add this line: `192.168.99.100 application.dev` Note: Change the `192.168.99.100` for the IP gived to you in the Step 2.
4.- In your Host Machine replace `project` for your project folder and also replace the new `project` folder name in your `docker-compose.yml`:
```
volumes:
  - ./project:/var/www/application
```
for:
```
volumes:
  - ./my_symfony_project:/var/www/application
```
5.- In the repo folder with your docker-machine up execute: `docker-compose up -d`
