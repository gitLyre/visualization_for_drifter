#update db
dropdb "leaflet_development"
createdb "leaflet_development"
rake db:migrate