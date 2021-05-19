require 'rails_helper'

RSpec.describe IssueMailerJob, type: :job do
  describe '#perform' do
    let(:bookissue) { create(:bookissue) }
    subject(:job) { described_class.perform_later(bookissue) }

    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it 'queues the job' do
      expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'queues in default queue' do
      expect(described_class.new.queue_name).to eq('default')
    end

    it 'enqueues in issue queue with correct arg' do
      expect {
        IssueMailerJob.set(queue: 'issue').perform_later(bookissue)
      }.to have_enqueued_job(IssueMailerJob).with(bookissue).on_queue('issue')
    end

    it 'block expectation' do
      expect { IssueMailerJob.perform_later(bookissue) }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'enqueues the job but mail does not reach' do
      expect(Delayed::Job.count).to eql(0)
      IssueMailerJob.new.delay(queue: 'issue').perform(bookissue)
      expect(Delayed::Job.count).to eql(1)
    end

    it 'enqueues job and add to delayed_jobs table' do
      expect {
        IssueMailerJob.delay(queue: 'issue').perform(bookissue)
      }.to change(Delayed::Job, :count).by(1)
    end

    it 'calls perform method of Issuemailer class' do
      expect { IssueMailerJob.perform(bookissue) }.to change(Delayed::Job, :count).by(1)
    end
  end
end
