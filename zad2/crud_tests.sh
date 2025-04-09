#!/bin/bash

BASE_URL="http://localhost:8000"
API_URL="$BASE_URL/product"
HEADER="Content-Type: application/json"


print_title() {
  echo -e "\n$1"
}

print_title "\n1. List all products:"
curl -s -X GET "$API_URL/"

print_title "\n2. Create new product:"
NEW_PRODUCT='{
  "name": "Test Product"
}'

CREATE_RESPONSE=$(curl -s -X POST "$API_URL/" \
  -H "$HEADER" \
  -d "$NEW_PRODUCT")

PRODUCT_ID=$(echo "$CREATE_RESPONSE" | grep -o '"id":[0-9]*' | cut -d':' -f2)
if [ -n "$PRODUCT_ID" ]; then
  echo "Created Product with ID: $PRODUCT_ID"
  echo "$CREATE_RESPONSE"
else
  echo "Error during Product creation"
  echo "$CREATE_RESPONSE"
  exit 1
fi


print_title "\n3. Get Product with ID $PRODUCT_ID:"
curl -s -X GET "$API_URL/$PRODUCT_ID"


print_title "\n4. Update product with ID $PRODUCT_ID:"
UPDATED_PRODUCT='{
  "name": "Updated Product"
}'

UPDATE_RESPONSE=$(curl -s -X PUT "$API_URL/$PRODUCT_ID" \
  -H "$HEADER" \
  -d "$UPDATED_PRODUCT")

if [[ "$UPDATE_RESPONSE" == *"Updated Product"* ]]; then
  echo "Updated Product with ID: $PRODUCT_ID"
  echo "$UPDATE_RESPONSE"
else
  echo "Error during Product update!"
  echo "$UPDATE_RESPONSE"
fi

print_title "\n5. List all products:"
curl -s -X GET "$API_URL/"


print_title "\n6. Remove Product with ID $PRODUCT_ID:"
DELETE_RESPONSE=$(curl -s -X DELETE "$API_URL/$PRODUCT_ID")

if [[ "$DELETE_RESPONSE" == *"deleted"* || "$DELETE_RESPONSE" == *"usunięto"* ]]; then
  echo "Removed product with ID: $PRODUCT_ID"
else
  echo "Error during product removal"
  echo "$DELETE_RESPONSE"
fi

print_title "\n7. List all products:"
curl -s -X GET "$API_URL/"

echo -e "\nTests have finished"