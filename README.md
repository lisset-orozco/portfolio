[![Continuous Integration](https://github.com/lisset-orozco/portfolio/actions/workflows/build_with_tests_and_linters.yml/badge.svg)](https://github.com/lisset-orozco/portfolio/actions/workflows/build_with_tests_and_linters.yml)

# Ruby on Rails on Docker with CI/CD

#### Heroku links

* ApiDoc: https://portfolio-fintual.herokuapp.com/api-docs
<p align="center">
  <kbd>
    <img src="miscellaneous/images/doc.png" title="workflow">
  </kbd>
</p>

#### ER Diagram

<p align="center">
  <kbd>
    <img src="miscellaneous/images/diagram.jpeg" title="workflow">
  </kbd>
</p>

## Quick start

### Configuration

* Ruby version: `3.1.1`
* Rails version: `7.0.2.3`

### Build project

```shell
docker compose build api
```

### Create database

```shell
docker compose run --rm api rails db:create
```

### Initialize database

```shell
docker compose run --rm api rails db:migrate
```

### Local deployment

```shell
docker compose up
```

> go to link `localhost:3000`

### Health check

> go to link `localhost:3000/health_check`

### Services

* postgresql: `14.2-alpine`
* redis: `7.0-rc-alpine`
* sidekiq: `6.4.1`

## Deploy on Heroku (only on master branch)

- create the next secrets in the repository

```shell
secrets.HEROKU_API_KEY
secrets.HEROKU_API_APP
secrets.HEROKU_API_EMAIL
```

- create an app on Heroku

```shell
heroku create --region us <APP-NAME>
```

- copy the `<APP-NAME>` to `HEROKU_API_APP`
- create authorizations

```shell
heroku authorizations:create
```

- copy the Token to `HEROKU_API_KEY`
- copy your heroku account email to `HEROKU_API_EMAIL`

## Workflow

<p align="center">
  <kbd>
    <img src="miscellaneous/images/workflow_ci_cd.png" title="workflow">
  </kbd>
</p>
