require "spec_helper"

describe QuikCV::Client do
  it "allows us to configure to set the API key" do
    QuikCV.configure { |conf| conf.token = 'abcd' }
    QuikCV.token.should eql 'abcd'
  end

  it "takes the users API key as an arguement" do
    QuikCV::Client.new 'abcd'
    QuikCV.token.should eql 'abcd'
  end

  it "makes a URL request to QuikCV's API url" do
    QuikCV::SITE.should eql 'http://api.quikcv.com/api'
  end

  it "has access to the API version" do
    QuikCV::API_VERSION.should eql 'v1'
  end

  describe "#personal_details" do
    before :each do
      @hash = {
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
        and_return @hash
    end

    it "allows me to retrieve my personal details" do
      QuikCV::Client.personal_details.should be_a Mash
    end

    it "can access to all response properties" do
      user = QuikCV::Client.personal_details
      expected = Mash.new @hash
      @hash.each do |prop, val|
        user.send(prop.to_sym).should eql expected.send(prop.to_sym)
      end
    end
  end

  describe "#profile" do
    before :each do
      @hash = 
        {
          contact_number:"0207 474 4444",
          email: "scooby@mystery.inc",
          mobile_number: "07890 012 345",
          full_name: "Scooby Doo",
          jobs:[
            {
            company_name:"Interface Pirate Radio",
             description:"Started by helping out with improvement to the PERL (which I had learnt in my spare time) based chat engine",
             end_date:"2007-12-13",
             role:"Freelance Web Developer",
             start_date:"2000-08-03"
            }
          ],
          courses:[
            {
              title:"Bootcamp",
              start_date:"2011-01-03",
              end_date:"2011-01-03"
            }
          ],
          qualifications:[
            {
              location:"Boodah College",
              outcomes:"Discordian Nonsense",
              start_date:"2011-01-03",
              end_date:"2011-01-29"
            }
          ],
          skillsets:[
            {
              type:"Database Systems",
              skills:"MySQL, CouchDB, Mnesia"
            }
          ]
        }
      QuikCV::My.
        stub(:get).
        with('profile', :auth_token => 'abcd').
        and_return @hash
    end
    
    it "returns a Mash object" do
      QuikCV::Client.profile.should be_a Mash
    end

    it "returns the expected entries" do
      QuikCV::Client.profile.full_name.should eql 'Scooby Doo'
    end

    it "allows me to get a count of my jobs" do
      QuikCV::Client.profile.jobs.count.should eql 1
    end
  end
end

