# Little Esty Shop

Little Esty Shop is a fictitious e-commerce site that uses ActiveRecord/SQL queries to interact with a PostgreSQL database. This project was used as a way to explore CRUD functionality, Rails MVC principles, and many-to-many relationships. Little Esty Shop provided hands on practice with BE database creation and manipulation. The collaborators on this project divided into two teams to develop an admin portion and merchant(user) portion of the site. The team used Github and Git workflows, as well as Github Projects to maintain consistency across the project. 

**Project Duration: 9 days**

## Schema:
![Little_Esty_Shop](https://user-images.githubusercontent.com/42476338/128379019-4b6a28ff-d263-4d2d-8608-7f4a98c0c508.png)

## Collaborators:
- Dane Brophy: [danembb](https://github.com/danembb) | [LinkedIn](https://www.linkedin.com/in/dane-brophy/)
- Jacob Piland: [Jtpiland](https://github.com/Jtpiland) | [LinkedIn](https://www.linkedin.com/in/jacob-piland-3a6083212/)
- Marla Schulz: [marlitas](https://github.com/marlitas) | [LinkedIn](https://www.linkedin.com/in/marla-a-schulz/)
- Samantha Peterson: [sami-p](https://github.com/sami-p) | [LinkedIn](https://www.linkedin.com/in/samantha-peterson-15b18220b/)

## Tech Stack/System Dependencies:
- Ruby on Rails
- PostgreSQL
- RSpec/Capybara
- SimpleCov
- Heroku
- Faraday
- Bootstrap

## [User Stories](./doc/user_stories.md)
## [Deployed Site](https://frozen-hollows-68377.herokuapp.com/admin)

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
