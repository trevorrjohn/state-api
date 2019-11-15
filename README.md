# About

The functionality of the app conforms to the prompt. However there are a few things that I would improve before shipping to production such as adding a caching layer ontop of the API to validate the country and state. You probably also want to rate limit the create/delete endpoint.

# Setup

## Run
Using `Docker`:

Setup the database

```
$ docker-compose run app rails db:create db:setup
```

Run the server

```
$ docker-compose up
```

By default the app will be served over `localhost:3000`

## Run Tests

Setup test database

```
$ docker-compose rails db:create db:migrate db:test:prepare
```

Run the tests

```
$ docker-compose run app rails test
```

# Documentation

### GET states for State and Country

GET [/api/v1/addresses?country=countryISO&state=stateAbrev](http://localhost:3000/api/v1/addresses?state=NY&country=USA)

Parameters are required:

- `state`: state abbreviation (eg. NY)
- `country`: country abbreviation (eg. USA)

### Create address

POST [/api/v1/addresses](http://localhost:3000/api/v1/addresses)

Request body:

All parameters are required

```json
{
   "address": {
     "name": "Home", // name of address
     "street": "9 Madison Ave", // name of street
     "city": "New York", // name of city
     "state": "NY", // state abbreviation
     "country": "USA" // country ISO code
   }
}
```

### Update an address

PUT [/api/v1/addresses/:id](http://localhost:3000/api/v1/addresses/id)

Request body:

ID is required in the URL path.

You can remove keys from the `address` object if you do not want to update those fields.

```json
{
   "address": {
     "name": "Home", // name of address
     "street": "9 Madison Ave", // name of street
     "city": "New York", // name of city
     "state": "NY", // state abbreviation
     "country": "USA" // country ISO code
   }
}
```

### Delete an address

DELETE [/api/v1/addresses/:id](http://localhost:3000/api/v1/addresses/id)

Request body:

ID is required in the URL path.


# Prompt

Write a NodeJS service using the express framework (or a derivative) that implements a set of RESTful style interfaces to:

• create address records containing a name, street, city, state, and country
• returning a unique key for each address record
• check that the state is valid for the country using an external REST service http://www.groupkt.com/post/f2129b88/free-restful-web-services-to-consume-and-test.htm
• note the URL for the API has changed to the domain www.groupkt.com instead of services.groupkt.com
• update and delete individual address records
• list all the stored address records for a given state and country

You can store the records in memory, or ideally in another service, such as mongodb or mysql. If you use a durable store, please provide a docker compose file or other instructions for setting up the store and running the DDL to initialize the schema (if necessary); alternatively you can do this as part of your server startup. Provide unit tests for testing your service, and curl commands or a small client for testing it. The JS code should use modern ES7 syntax.

You can use whatever technique is most efficient and elegant, but you should not spend more than a day or two on the challenge. Make sure your solution is clear and well tested.

Provide the solution as a public Github project. Also provide links to any services you tested it against and any necessary instructions for running your code.  Ideally you should make multiple commits to the challenge project so we can see how you evolve the code over time and what you were trying to achieve with each commit.  Do at least one commit before you start testing and one commit for each major bug fix. Feel free to contact me with any questions you have.
