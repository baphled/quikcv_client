require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'resources', 'my.rb')
describe QuikCV::My do
  it "stores the site url" do
    QuikCV::My.site.to_s.should eql 'http://api.quikcv.com/api/v1'
  end

  describe "/personal_details" do
    context 'successful request' do
      before :each do
        @response = {
          full_name: 'Scooby Doo',
          contact_number: '0207 444 4444',
          mobile_number: '07890 789 1234',
          email: 'scooby@mystery.inc',
          profession: 'private eye',
          availability: 'Currently available'
        }
        QuikCV::My.
          stub(:get).
          with('personal-details', :auth_token => 'abcd').
          and_return @response
        @user = QuikCV::My.get('personal-details', :auth_token => 'abcd')
      end
      
      it "returns my full name" do
        @user[:full_name].should eql 'Scooby Doo'
      end

      it "returns my contact details" do
        @user[:contact_number].should eql @response[:contact_number]
        @user[:mobile_number].should eql @response[:mobile_number]
        @user[:email].should eql @response[:email]
      end
    end
  end
end
