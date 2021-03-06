require 'spec_helper'

describe Publisher do
  it { expect(subject.class).to respond_to(:acts_as_publisher) }
  it { expect(subject.class).to respond_to(:acts_as_subscriber) }
  it { expect(subject).to respond_to(:publish) }
  it { expect(subject).to respond_to(:subscribers) }
  it { expect(subject).not_to respond_to(:subscribe) }
  it { expect(subject).not_to respond_to(:unsubscribe) }
  it { expect(subject).not_to respond_to(:notifications) }
    
  describe ".subscribers" do
    let(:subscriber) { FactoryGirl.create(:subscriber) }
    let(:publisher) { FactoryGirl.create(:publisher) }
    
    it { expect(subject.subscribers).to be_kind_of Array }
    it { expect(subject.subscribers.count).to eq 0 }
    
    context "with subscribers" do
      let!(:subscription) { subscriber.subscribe publisher }
      it { expect(publisher.subscribers.count).to eq 1 }
      it { expect(publisher.subscribers).to include subscriber.active_publisher_key }

      describe "recieve notifications" do
        let!(:notification) { publisher.publish(:test) }
        it { expect(subscriber.notifications.count).to eq 1 }
      end
    end
    
  end
end
