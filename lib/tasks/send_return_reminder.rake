namespace :send_return_reminder do
  desc 'Send emails to remind about return date'
  task remind: :environment do
    Bookissue.all.each do |bookissue|
      ReminderMailer.reminder(bookissue).deliver
    end
  end
end
