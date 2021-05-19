require 'rails_helper'

describe 'Whenever Schedule' do
  before do
    load 'Rakefile'
  end

  it 'makes sure `runner` statements exist' do
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')

    assert_equal 1, schedule.jobs[:rake].count

    # Executes the actual ruby statement to make sure all constants and methods exist:
    schedule.jobs[:rake].each { |job| instance_eval job[:task] }
  end

  it 'makes sure `rake` statements exist' do
    # config/schedule.rb file is used by default in constructor:
    schedule = Whenever::Test::Schedule.new(vars: { environment: 'development' })

    # Makes sure the rake task is defined:
    assert Rake::Task.task_defined?(schedule.jobs[:rake].first[:task])
  end 
end
