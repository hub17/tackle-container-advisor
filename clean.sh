#!/bin/bash

version="1.0.4"
db_file="$version.db"
shopt -u extglob

echo "-----------Cleaning Files and Folders---------"

##remove files from entity standardization models
if [ -d models/ ]; then
    rm -rf models/
fi

if [ -d kg/ ]; then
  #save  infer_negative.json
  cp kg/infer_negative.json  /app/

fi
#remove files from ontologies
if [ -d kg/ ]; then

    cd kg/
    GLOBIGNORE=infer_negative.json
    rm -v  *
    cd ..
fi

## remove db file from DB
if [[ -f db/$db_file ]]; then
    rm db/$db_file
fi

## remove files from data for entity standardization training/experiments
if [[ -d data/ ]]; then
    rm -rf data/
fi

## remove packages from entity standardizer
cd entity_standardizer
pip3 uninstall dist/entity_standardizer_tca-1.0-py3-none-any.whl -y
cd ..

if [[ -d entity_standardizer/dist/ ]]; then
    rm -rf entity_standardizer/dist/
fi

if [[ -d entity_standardizer/entity_standardizer_tca.egg-info/ ]]; then
    rm -rf entity_standardizer/entity_standardizer_tca.egg-info/
fi


## remove any logs
rm *.log

echo "-----------Cleaning Completed---------"
