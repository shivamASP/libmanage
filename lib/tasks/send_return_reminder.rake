namespace :send_return_reminder do
  desc 'Send emails to remind about return date'
  task remind: :environment do
    bookissues = Bookissue.all
    bookissues.each do |bookissue|
      ReminderMailer.reminder(bookissue).deliver
    end
  end
end
