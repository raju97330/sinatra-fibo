# Simple Sinatra application

This is a simple Sinatra Ruby application copied from Cloud Foundry's README.

## Local development

    sudo gem install bundler
    bundle install
    ruby fibo.rb

## Deploying to Stackato

    sudo gem install bundler
    bundle install  # creates the required Gemfile.lock file
    stackato push -n


To test autoscaling:

1. Set the autoscaling parameters.  I find something like
CPU 20-40% and 2-5 instances works.

2. Run the command:

    ruby client/drive-fibo.rb <ENDPOINT>

3. The health-manager, by default, lags by about a minute.  Use
the following settings to speed it up:

kato config set health_manager intervals/cpu_autoscaling_heartbeat_interval N

  default N is 6, which means it might do an autoscale every N heartbeats, or
  60 seconds

kato config set health_manager autoscaling/cooldown_period N -- default
is 180 secs, to keep the health_manager from duplicating pending requests.

kato config set dea_ng intervals/heartbeat N -- default is every 10 secs
