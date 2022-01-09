# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: Ruby-3.0.0

* System dependencies
  - to install mysql
    - update system sudo apt update
    - install mysql
        ```
        sudo apt install mysql-server
        ```
    - install lib for builing native extension
      ```
      sudo apt install libmysqlclient-dev
      ```
  - to  install nodejs
    - download nodejs binary file from nodejs.org(version=16.13.1)
    - extract the files in following directory(create if it does not exists)
      ```
      sudo tar xf node-v16.13.1-linux-x64 -C /usr/local/lib/nodejs
      ```
    - set the environment variable by following at the end of ~/.profile file
      ```
      VERSION=v16.13.1
      DISTRO=linux-x64
      export PATH=/usr/loca/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
      ```
    - refresh ~/.profile
      ```
      . ~/.profile
      ```
  - to install yarn
    - insure that cmdtest is not install
      ```
      sudo apt remove cmdtest
      ```
    - configure repository
      ```
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      ```
    - update the system and install yarn
      ```
      sudo apt update
      sudo apt install yarn
      ```
* Configuration
  - to configure mysql
    - create user
      ```
      CREATE USER '<usename>'@'<host>' IDENTIFIED BY '<password>';
      ```
    - grant privileges
      ```
      GRANT CREATE, DROP, ALTER, SELECT, INSERT, UPDATE, DELETE, INDEX, REFERENCES ON *.* TO '<username>'@'<host>';
      ```
  - to configure webpacked/stimulus
    ```
    rake webpacked:install
    ```
* Database creation
  ```
  rake db:create
  ```

* Database initialization
  ```
  rake db:migrate
  rake db:seed
  ```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
