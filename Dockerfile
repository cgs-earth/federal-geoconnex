FROM internetofwater/pygeoapi:latest
# Updated 2022-05-30

#add requirements and mods
COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml
#COPY ./jsonld /pygeoapi/pygeoapi/templates/jsonld
#COPY ./data /data
