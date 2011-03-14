# spec for Layout Model
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe User do   
  before(:each) do
    @layout = Layout.make!
  end
  
  context "mass assignment" do
    it "should protect against mass assignment of created_by_id and updated_by_id" do
      layout = Layout.new(:updated_by_id => mock_model("User").id, :created_by_id => mock_model("User").id)
      layout.created_by_id.should be_nil
      layout.updated_by_id.should be_nil
    end
    
    it "should not allow mass assignment of" do
      @layout.should_not allow_mass_assignment_of(:created_by_id => mock_model("User").id, :updated_by_id => mock_model("User").id)
    end
    
    it "should allow mass assignment of" do
      @layout.should allow_mass_assignment_of(:name => "foobar", :content => "Hello,World!")
    end
  end
  
  context "before_validation set layout filter if it isn't set" do
    it "should set the default filter to haml before saving" do
      @layout.filter = nil
      @layout.save
      @layout.filter.name.should == "haml"
    end
  end
  
  context "validations" do
    it "should create a valid user with valid attributes" do
      @layout.should be_valid
    end
    
    it "should not be valid without a layout name" do
     @layout.name = nil
     @layout.should_not be_valid
    end
    
    it "should not be valid without a unique layout name" do
      Layout.make(:name => "#{@layout.name}").should_not be_valid
    end
    
    it "should not be valid without content" do
      @layout.content = nil
      @layout.should_not be_valid
    end
    
    it "should not be valid without a filter" do
      @layout.stub(:set_filter).and_return(nil)
      @layout.filter = nil
      @layout.should_not be_valid
    end
    
    it "should not be valid without createb_by_id" do
      @layout.created_by_id = nil
      @layout.should_not be_valid
    end
    
    it "should validate associated user instance in created_by" do
      @layout.created_by_id = nil
      @layout.should_not be_valid
    end
    
    it "should not be valid without updated_by_id" do
      @layout.updated_by_id = nil
      @layout.should_not be_valid
    end
    
    it "should validate associated user instance in updated_by" do
      @layout.updated_by_id = nil
      @layout.should_not be_valid
    end   
  end
  
  context "associations" do
    it "should reference a user with created_by" do
      @layout.should be_referenced_in(:created_by).of_type(User).as_inverse_of(:layouts_created)
    end
    
    it "should reference a user with updated_by" do
      @layout.should be_referenced_in(:updated_by).of_type(User).as_inverse_of(:layouts_updated)
    end
  end
end