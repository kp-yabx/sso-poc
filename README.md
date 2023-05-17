# SAML-based user provisioning POC

### Required
* Ruby v.3.2.2
* Rails v.7.0.4
* DB: SQLlite DB
* Docker & Docker compose

### How to configure
1. Install or switch to Ruby v3.2.x
2. Install bundle: `bundle install`
3. Run migration: `bin/rails db:migrate`
4. Run development: `bin/rails server`
5. Run Docker compose from project root: `docker compose up -d`
6. Access the project using localhost: [localhost](http://localhost:3000)

### User flow:
1. Sign and login to view the users present
2. Sign In using option: *Log in with SSO*


### Sample SSO users:
1. user1/user1pass
2. user2/user2pass
3. user3/user3pass

