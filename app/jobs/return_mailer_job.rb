class ReturnMailerJob < ApplicationJob
  queue_as :default

  def self.perform(book, user)
    # will add lirary mailer job to delayed_jobs table to run after 1 minute on return queue
    # and 'rake jobs:work' command has to be run to perform this job
    LibraryMailer.delay(queue: 'return', run_at: 1.minute.from_now).return(book, user)

    # will enqueue library mailer job to acitve job and perform as soon as a worker is available
    # no need to run 'rake jobs:work'
    # LibraryMailer.return(book, user).deliver_later(wait: 1.minute)
  end
end
