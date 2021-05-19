class IssueMailerJob < ApplicationJob
  queue_as :default

  def self.perform(issue_data)
    # will add lirary mailer job to delayed_jobs table to run after 1 minute on return queue
    # and 'rake jobs:work' command has to be run to perform this job
    LibraryMailer.delay(queue: 'issue', run_at: 1.minute.from_now).issue(issue_data)

    # will enqueue library mailer job to acitve job and perform as soon as a worker is available
    # no need to run 'rake jobs:work'
    # LibraryMailer.issue(issue_data).deliver_later(wait: 1.minute)
  end
end
