# Awesome Contacts Importer

[![Ruby](https://github.com/iagopiimenta/awesome-contacts-importer/actions/workflows/ruby.yml/badge.svg)](https://github.com/iagopiimenta/awesome-contacts-importer/actions/workflows/ruby.yml)

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
