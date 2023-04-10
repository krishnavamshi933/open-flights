# Use the official Ruby base image with a specific version
FROM ruby:2.7

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Run database migrations
RUN bundle exec rails db:prepare

# Install Node.js dependencies
RUN npm install

# Expose the port on which the application will run
EXPOSE 3000

# Start the Rails application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
