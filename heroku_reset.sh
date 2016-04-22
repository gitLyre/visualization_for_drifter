#removes the current db and prepares it for new data
heroku pg:reset DATABASE_URL --app testdrifters
heroku run rake db:migrate
#heroku run rake db:seed no seeds yet
