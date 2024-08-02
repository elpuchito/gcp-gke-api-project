
#!/bin/bash

API_URL=$1

if [ -z "$API_URL" ]; then
  echo "Usage: $0 <api-url>"
  exit 1
fi

echo "Testing API health endpoint..."
curl -s -o /dev/null -w "%{http_code}" http://${API_URL}/health

if [ $? -eq 0 ]; then
  echo "API is healthy"
else
  echo "API health check failed"
  exit 1
fi

# Add more API tests here
