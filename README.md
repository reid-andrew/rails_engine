# Rails Engine

This application is the backend portion of the [Rails Engine](https://backend.turing.io/module3/projects/rails_engine) project for the Turing School of Software and Design.

It is a Ruby on Rails API application which includes 

1. A Test Suite for Rails Engine
1. A Back End used by [Rails Driver](https://github.com/reid-andrew/rails_driver) 
1. A Rake Task for clearing and seeding the Development database from .csv files stored in the application

## Versions
- Rails 5.1.7
- Ruby 2.5.3

## Setup
1. Clone the Rails Driver application and follow setup instructions in that repo
1. CLone this repository and run the following commands:
  1. `bundle`
  1. `rails db:create`
  1. `rake db:reload` This will seed the development database with original data from the .csv files neccessary to run the Rails Driver test suite
  1. Run this application using the command `rails s` in order to use Rails Drive or run it's test suite

## Schema
![rails_engine_schema](https://github.com/reid-andrew/rails_engine/blob/master/schema.png?raw=true)

Screen Shot 2020-05-22 at 12.51.30 PM.png
