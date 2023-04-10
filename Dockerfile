# Use the official Ruby base image with a specific version
FROM ruby:3.0.3

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Set the environment variable for the database password
ARG APPNAME_DATABASE_PASSWORD
ENV APPNAME_DATABASE_PASSWORD $APPNAME_DATABASE_PASSWORD

# Replace the database.yml with the one that contains the database password
RUN sed -i "s/%= ENV\['APPNAME_DATABASE_PASSWORD'\] %/$APPNAME_DATABASE_PASSWORD/" config/database.yml

# Run rails db:create to create the PostgreSQL database
RUN bundle exec rails db:create

# Expose the port on which the application will run
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]
