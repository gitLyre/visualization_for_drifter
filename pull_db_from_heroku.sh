#pull heroku and store it as mydbleaf
createdb mydbleaf
dropdb mydbleaf
heroku pg:pull DATABASE_URL mydbleaf --app testdrifters3
