#!/bin/bash

# Configuration
MAX_ATTEMPTS=5
GRAPHQL_ENDPOINT="https://backend.dcw.fairbankcenter.org/graphql"
OUTPUT_FILE="data/all.json"

# GraphQL query
QUERY='{"query": "query { pages { id slug date_updated translations { id languages_code { code } content } } resources { id slug status title url abbreviation date_updated creator { id } translations { id title_translated languages_code { code } summary description content_status } creator { creators_id { id } } } creators { id slug status title url abbreviation date_updated translations { id title_translated languages_code { code } description } } }"}'

download_data() {
    local attempt=1
    while [ $attempt -le $MAX_ATTEMPTS ]; do
        echo "Attempt $attempt of $MAX_ATTEMPTS"
        
        # Make the curl request
        response=$(curl -s -w "\n%{http_code}" -X POST "$GRAPHQL_ENDPOINT" \
            -H "Content-Type: application/json" \
            -d "$QUERY" \
            --max-time 300 \
            --retry 3 \
            --retry-delay 5 \
            --retry-max-time 60)
        
        # Extract HTTP status code and content
        http_code=$(echo "$response" | tail -n1)
        content=$(echo "$response" | sed '$d')
        
        if [ "$http_code" = "200" ]; then
            if echo "$content" | jq -e . >/dev/null 2>&1; then
                if ! echo "$content" | jq -e '.errors' >/dev/null 2>&1; then
                    echo "$content" > "$OUTPUT_FILE"
                    echo "Download successful. Data saved to $OUTPUT_FILE"
                    return 0
                else
                    echo "GraphQL returned errors:"
                    echo "$content" | jq '.errors'
                fi
            else
                echo "Response is not valid JSON:"
                echo "$content"
            fi
        else
            echo "Download failed. HTTP Code: $http_code"
            echo "Response: $content"
        fi
        
        if [ $attempt -eq $MAX_ATTEMPTS ]; then
            echo "Max attempts reached. Download failed."
            return 1
        fi
        
        echo "Retrying in 5 seconds..."
        sleep 5
        attempt=$((attempt+1))
    done
}

# Ensure the data directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Run the download function
download_data