require 'rubygems'
require 'oauth'  # using generic version installed 0.3.6
require 'rexml/document'
require '../lib/rforce'
require 'test/unit'

# Setup a Development org and generate a consumer key and secret, fill in these values
CONSUMER_KEY = ''
CONSUMER_SECRET = ''

# get an access token using the oauth process.  You'll need to use the ruby-oauth
# gem and write an oauth controller, then capture the tokens from the logs
# In real life the tokens are stored for every user and reused when ever the 
# API needs to be queried on behalf of the user.
ACCESS_TOKEN = ""
ACCESS_SECRET = ""
# TODO: mock up oauth process so real tokens aren't necessary.

# This may need to be updated
OAUTH_API_URL = 'https://login.salesforce.com/services/OAuth/u/18.0'

class OauthTests < Test::Unit::TestCase
  
  # Validates that the new version of Rforce works with oauth 
  def test_get_session_id_and_data
    oauth_params = {
      :access_token => ACCESS_TOKEN,
      :access_secret => ACCESS_SECRET,
      :login_url     => OAUTH_API_URL,
      :consumer_key  => CONSUMER_KEY,
      :consumer_secret => CONSUMER_SECRET 
    }
    binding = RForce::Binding.new(OAUTH_API_URL, nil, oauth_params)
    response = binding.login_with_oauth
    assert_not_nil response[:sessionId]
    user = binding.getUserInfo({})
    assert_not_nil user.getUserInfoResponse.result.userId
  end
  
  

end  