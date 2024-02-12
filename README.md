# README

## Usage
The app is deployed in fly.io and can be reached on https://pennylane-test.fly.dev/.

There's one single endpoint to search for recipes: https://pennylane-test.fly.dev/recipes/search.
This endpoint accepts the `ingredients` query parameter.
This parameter is a comma separated list of ingredients to search for.
If nothing is passed then the endpoint will return an empty response otherwise it'll return the recipes whose ingredients match the search.
The responses are always in JSON format

### Example
#### Request
```http request
GET https://pennylane-test.fly.dev/recipes/search?ingredients=cinnamon,egg
```

#### Response
```json
[
    {
        "id": 1,
        "title": "Golden Sweet Cornbread",
        "cook_time": 25,
        "prep_time": 10,
        "ratings": 4.74,
        "cuisine": "",
        "category": "Cornbread",
        "author": "bluegirl",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg",
        "created_at": "2024-02-09T11:49:54.278Z",
        "updated_at": "2024-02-09T11:49:54.278Z",
        "ingredients": [
            {
              "id": 1,
              "name_and_quantity": "1 cup all-purpose flour",
              "recipe_id": 1,
              "created_at": "2024-02-09T11:49:54.291Z",
              "updated_at": "2024-02-09T11:49:54.291Z"
            },
            {
              "id": 2,
              "name_and_quantity": "1 cup yellow cornmeal",
              "recipe_id": 1,
              "created_at": "2024-02-09T11:49:54.294Z",
              "updated_at": "2024-02-09T11:49:54.294Z"
            }
          ]
    },
    {
        "id": 2,
        "title": "Monkey Bread I",
        "cook_time": 35,
        "prep_time": 15,
        "ratings": 4.74,
        "cuisine": "",
        "category": "Monkey Bread",
        "author": "deleteduser",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2018%2F11%2F546316.jpg",
        "created_at": "2024-02-09T11:49:54.303Z",
        "updated_at": "2024-02-09T11:49:54.303Z",
        "ingredients": [
            {
              "id": 9,
              "name_and_quantity": "3 (12 ounce) packages refrigerated biscuit dough",
              "recipe_id": 2,
              "created_at": "2024-02-09T11:49:54.304Z",
              "updated_at": "2024-02-09T11:49:54.304Z"
            }
        ]
    }
]
```


## Local set-up
To run this project locally follow these instructions:

1. Install ruby
2. Install postgresql (e.g. `brew install postgresql` on Mac)
3. Make sure postresql is running (e.g. `brew services start postgresql` on Mac to make sure it always runs on startup)
4. Install the bundler gem (`gem install bundler`) and run `bundle install`
5. Run `rails db:prepare`
6. Run `rails s` to start the server

Now you can query locally with:
```http request
GET http://127.0.0.1:3000/recipes/search?ingredients=cinnamon,egg
```

## Project dependencies
 - Ruby version - 3.2.2
 - Rails version - 7.1.3
 - PostgreSQL version - 14.10
