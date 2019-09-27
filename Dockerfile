FROM ubuntu:16.04

# Switch to root
USER root

# Work Directory
WORKDIR project/installations/

# Update everything
RUN apt-get update

# Install Dependencies
RUN apt-get install -y build-essential \
					   zlib1g-dev \
					   locales \
					   curl \
					   git \
					   openjdk-8-jre \
					   ssh \
					   jq
					   
# Install Ruby & Gems
RUN apt-get install -y ruby-full
RUN mkdir -p /usr/share/ruby
COPY Gemfile /project/installations/
COPY Gemfile.lock /project/installations/
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install --system
RUN gem clean

# Environment Setup
ENV TZ=Asia/Calcutta
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
