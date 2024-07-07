#!/bin/bash

# Load environment variables from .env file
set -o allexport
source .env
set +o allexport

# Escape the query string for JSON
GRAPHQL_QUERY_ESCAPED=$(echo $GRAPHQL_QUERY | jq -Rs '.')

# Run the curl command
curl -X POST $GRAPHQL_ENDPOINT -H "Content-Type: application/json" -d "{\"query\": $GRAPHQL_QUERY_ESCAPED}" > data/data.json