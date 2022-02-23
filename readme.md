1. Clone the repo

      git clone https://github.com/ahmelnychyi/laravel_quick_start

2.    set permissions on the project directory so that it is owned by your non-root user:
      chown -R your_user:your_user ~/laravel_quick_start
      
      cd laravel_quick_start

3. Open .docker-compose.yml  file and change user=sammy and uid=1004  
   to the username under which you log in to the development server 
   and his UID (run in the terminal  echo $UID)
       args:
        - user=sammy 
        - uid=1004 
        ////
        args:
    - user=your_user
    - uid=your user UID ((run in the terminal  echo $UID))
    
4. Starting server, run the command and wait a few minutes

   docker-compose up -d
   
5. docker-compose exec app bash

        composer install

        php artisan migrate
   
        php artisan serve
        
6. Enjoy the project at http://localhost:8000/
7. To stop project, use docker-compose down. To start project, use docker-compose up -d
