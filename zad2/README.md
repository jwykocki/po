# symfony_app

To run it:
`docker run -it --rm -v $(pwd):/app -w /app -p 8000:8000 kprzystalski/projobj-php:latest`

`php -S 0.0.0.0:8000 -t public`

`./crud_tests.sh`

### Example test output:
./crud_tests.sh


1. List all products:
[{"id":2,"name":"Smartphone"},{"id":3,"name":"Tablet"},{"id":4,"name":"Monitor"},{"id":5,"name":"Keyboard"}]

2. Create new product:
Created Product with ID: 12
{"id":12,"name":"Test Product"}


3. Get Product with ID 12:
{"id":12,"name":"Test Product"}

4. Update product with ID 12:
Error during Product update!
{"message":"Updated"}


5. List all products:
[{"id":2,"name":"Smartphone"},{"id":3,"name":"Tablet"},{"id":4,"name":"Monitor"},{"id":5,"name":"Keyboard"},{"id":12,"name":"Updated Product"}]

6. Remove Product with ID 12:
Error during product removal
{"message":"Deleted"}


7. List all products:
[{"id":2,"name":"Smartphone"},{"id":3,"name":"Tablet"},{"id":4,"name":"Monitor"},{"id":5,"name":"Keyboard"}]
Tests have finished