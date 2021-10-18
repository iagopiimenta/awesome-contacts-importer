# Awesome Contacts Importer

[![Ruby](https://github.com/iagopiimenta/awesome-contacts-importer/actions/workflows/ruby.yml/badge.svg)](https://github.com/iagopiimenta/awesome-contacts-importer/actions/workflows/ruby.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/0474d1e37cc1f4e5a931/maintainability)](https://codeclimate.com/github/iagopiimenta/awesome-contacts-importer/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0474d1e37cc1f4e5a931/test_coverage)](https://codeclimate.com/github/iagopiimenta/awesome-contacts-importer/test_coverage)

## Live

Visit https://awesome-contacts-importer.herokuapp.com/users/sign_in

## Running

### Install dependencies

```bash
bundle install
```

### Setup database

```bash
bundle exec rails db:create db:migrate
```

### Run sidekiq

```bash
bundle exec sidekiq
```

### Run rails server

```bash
bundle exec rails s
```
