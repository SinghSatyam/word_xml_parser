require 'rails_helper'

RSpec.describe ParsesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Parse. As you add validations to Parse, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ParsesController. Be sure to keep this updated too.
  #let(:valid_session) { {} }

  describe "Get Desired XML From XML" do
    it "parses the XML" do

      get :parse
      #expect(assigns(:parses)).to eq([parse])
      #response.body.should == parse
       response.should be_ok
      JSON.parse(response.body).should be true
    end
  end

  #describe "GET show" do
  #  it "assigns the requested parse as @parse" do
  #    parse = Parse.create! valid_attributes
  #    get :show, {:id => parse.to_param}, valid_session
  #    expect(assigns(:parse)).to eq(parse)
  #  end
  #end

end
