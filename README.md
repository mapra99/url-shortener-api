# URL Shortener API

Submit a URL and get a short alternative that can be used instead of the original one. Add also a custom path if you need prettier links. Get Stats around the use of your short URLs.

## Built With

- Ruby 3, Rails 6
- PostgreSQL
- Redis
- Sidekiq and Sidekiq-cron
- RSpec, shoulda matchers and factory bot
- Jbuilder

## Live Demo

[Live Demo Link](https://lit-url.herokuapp.com/)

[API Docs Here](https://documenter.getpostman.com/view/10455715/TzK16vGK#47d54b79-36ac-4c95-8b1b-b07c9ace094f)

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Ruby 3.0.0 is required. If you're using rbenv you may need to `rbenv install 3.0.0`
- Bundler for ruby package management. You may install it with `gem install bundler -v '2.2.3'`
- PostgreSQL
- Redis.
- You may want to use Postman or curl to play with the API.

### Installation

1. Clone this repo in your local environment and cd to the project's folder
```
git clone git@github.com:mapra99/url-shortener-api.git
cd url-shortener-api
```

2. Install the project dependencies
```
bundle install
```

3. Add your local postgres username and password, and add those credentials in your `.env`. Also add your local redis instance URL:
```
PG_USERNAME=postgres
PG_PASSWORD=mypassword123
REDIS_URL=redis://localhost:6379
```

4. Create the database and run the migrations
```
rails db:create
rails db:migrate
```

5. Run sidekiq on a separate terminal
```
bundle exec sidekiq
```

6. Start the server
```
rails server
```
### Usage

This project is a backend API. Following the setup steps, you'll get the API running at http://localhost:3000. You may want to use Postman or curl to have a playground with the API,

Feel free to visit the [API docs here](https://documenter.getpostman.com/view/10455715/TzK16vGK#47d54b79-36ac-4c95-8b1b-b07c9ace094f).

The project is currently using sidekiq to have a scheduled background job that removes old urls that haven't been visited in the last 6 months. To monitor these resources you can go to http://localhost:3000/sidekiq.

### Run tests

This project is using RSpec as testing framework. To check the tests do the following:
If you have a manual setup, run:
```
bundle exec rspec
```

## Authors

**Miguel Prada**

- GitHub: [@mapra99](https://github.com/mapra99)
- LinkedIn: [/in/mprada/](https://www.linkedin.com/in/mprada/?locale=en_US)

## Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## License

This project is [MIT](lic.url) licensed.
