Rails.application.load_tasks

describe 'send_return_reminder_remind' do
  let!(:bookissue) { create(:bookissue) }

  it 'it does sends messages' do
    Rake::Task['send_return_reminder:remind'].invoke
  end
  it 'Checking the mail is being called' do
    expect do
      perform_enqueued_jobs do
        ReminderMailer.reminder(bookissue).deliver!
      end
    end.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
end
