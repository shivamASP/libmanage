# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :environment, 'development'
set :path, '/home/mb/ror-simple-project'
set :output, 'log/cron_log.log'
set :bundle_command, "/usr/local/bin/bundle exec"

every 2.minute do
  runner 'send_return_reminder:remind'
  rake 'send_return_reminder:remind'
end
