require 'rails_helper'

RSpec.describe ReturnMailerJob, type: :job do
  describe '#perform' do
    let(:book) { create(:random_book, :skip_validate) }
    let(:user) { create(:random_user) }
    subject(:job) { described_class.perform_later(book, user) }

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
        ReturnMailerJob.set(queue: 'return').perform_later(book, user)
      }.to have_enqueued_job(ReturnMailerJob).with(book, user).on_queue('return')
    end

    it 'block expectation' do
      expect { ReturnMailerJob.perform_later(book, user) }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'enqueues the job but mail does not reach' do
      expect(Delayed::Job.count).to eql(0)
      ReturnMailerJob.new.delay(queue: 'return').perform(book, user)
      expect(Delayed::Job.count).to eql(1)
    end

    it 'enqueues job and add to delayed_jobs table' do
      expect {
        ReturnMailerJob.delay(queue: 'return').perform(book, user)
      }.to change(Delayed::Job, :count).by(1)
    end

    it 'calls perform method of ReturnMailer class' do
      expect { ReturnMailerJob.perform(book, user) }.to change(Delayed::Job, :count).by(1)
    end
  end
end
