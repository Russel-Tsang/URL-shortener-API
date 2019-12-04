## Intial Setup

    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate

## To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

## To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

## Run the web server

    docker-compose up

## Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

## Getting the top 100

    curl localhost:3000

## Checking your short URL redirect

    curl -I localhost:3000/abc

## Calculating the shortened URL

* Inititalize a short_code variable to represent the resulting string
* While given id_num is greater than 0, we find the base-62 remainder with (id_num % 62)
* This remainder represents the index within CHARACTERS to search for, so find CHARACTERS[remainder]
* Prepend CHARACTERS[remainder] to short code and reassign id_num to id_num / 62
* We reassign id_num because if id_num > 0 is still the case, we know we must repeat the process
* Return short_code at the end

```ruby
CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

def create_short_code(id_num)
    short_code = ''

    # find base62 counterpart of id number
    while (id_num > 0)
      new_char = CHARACTERS[id_num % 62]
      short_code = new_char + short_code
      id_num /= 62
    end
    short_code
end
```
