# Lending_money_with_interest
Tech-stack: Ruby on Rails , sidekiq, whenever, active job, devise gem

# Project Setup 

1. Configure database 

  go to -> config/database.yml
  
   add credetial
   
   host: localhost

   username: dbname
   
   password: dbpassword
   
2. Create Database 

   run command in terminal --> rails db:create
   
3. Migrate database 

   run command --> rails db:migrate

4. Create the Admin and user data from seed file

   run command --> rails db:seed

5. Start the rails Server 

   run command --> rails s 

6. copy the server url and paste on browser

   getting like this -->  http://127.0.0.1:3000

7. sign_in the Admin 
   # use below creadentials for admin login

   username: admin@gmail.com
   password: Admin@123

8. sign_in the User

  # use below creadentials for user login

    username: user@gmail.com
    password: User@123

9. setup the sidekiq the properly 

    if sidekiq not running due any configuration. that time you can test by using rails console given below.

    # A. open rails console 

     command -> rails c 
     run the job by using this -->  CalculateInterestJob.perform   

     [by using this job you can get total amount every 5 minutes]




