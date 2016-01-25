#convert dumpfile into your db
file_path=drifter.dump
bash clean_local.sh
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U guillaume -d leaflet_development $file_path
