# Use the official Ruby image
FROM ruby:3.2.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the required gems
RUN gem install bundler -v 2.3.7
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Remove server PID file and precompile assets (optional for production)
RUN rm -f tmp/pids/server.pid

# Expose port 3000 to the host
EXPOSE 3000

# Set the default command to run when the container starts
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
