#file for wiping local, pulling from heroku, and making a dump file
bash pull_db_from_heroku.sh
bash clean_local.sh
pg_dump mydbleaf  | psql -U guillaume -d leaflet_development
#rake db:seed -- no good seed data
dropdb mydbleaf
rm drifter.dump
pg_dump -Fc --no-acl --no-owner -h localhost -U guillaume leaflet_development > drifter.dump
