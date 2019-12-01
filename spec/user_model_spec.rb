require 'rails_helper'
require 'user'

describe User do 
    describe '#expired' do
        it "does nothing" do
            expect(User.first.expired).to eql(nil)
        end
    end
end