# Design considerations
The application is a small sinatra app that consist of a form that collects the user input and sends it to /postcode endpoint using a get request. Before we check if the postcode is allowed or not, we validate that the user input has a valid uk postcode format (uk_postcode gem). If the input is not valid an error will be raised and Invalid Input sent back to the client. If the input is valid we will proceed to check if the postcode is allowed or not. The logic involved checking whether a user is allowed or not consisting of a simple API in charge of fetching the postcode info from postcodes.io, and two classes (AreaChecker and LsoaFormatter) to handle the response. LsoaFormatter will split the lsoa field coming from postcodes.io into area and code. AreaCehcker will use the area f

# Tools
We have use an small set of tools for development:

- Rucocop: to check code standars and linting.

- Rspec: for testing purposes

- pry: for debugging purposes


# How to run the application
In order to run the application you need to clone the repo locally and execute the following steps

  - bundle install

  - bundle exec postcode_checker.rb

The application runs on WEBrick on port 4567. so in order to access the application
you need to navigate in your browser to http://localhost:4567

# how to test the application
For testing I have use Rspec testing library, adding both feature tests to test the application end to end, and some unit tests to test for edge cases on some classes.
In order to run the test you need to run:
bundle exec rspec.
