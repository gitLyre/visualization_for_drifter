#pushes current data on leaflet dev to heroku
createdb mytempdb
pg_dump -U guillaume  leaflet_development | psql -U guillaume -d mytempdb
heroku pg:reset DATABASE_URL --app testdrifters3
heroku run rake db:migrate
PGUSER=guillaume heroku pg:push mytempdb DATABASE_URL --app testdrifters3
heroku run rake db:seed
dropdb mytempdb
