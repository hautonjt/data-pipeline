#!/bin/bash

curl -X POST -H "osd-xsrf: true" -u admin:admin -F file=@index-patterns.ndjson "http://localhost:32001/api/saved_objects/_import?overwrite=true"
