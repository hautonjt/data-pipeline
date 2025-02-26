#!/bin/bash

curl -X POST -H "osd-xsrf: true" -u admin:admin -F file=@export.ndjson "http://localhost:32001/api/saved_objects/_import?overwrite=true"
