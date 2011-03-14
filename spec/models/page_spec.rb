require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe Page do   
  before(:each) do
    @page = Page.make!
  end
  
  context "mass assignment" do
    it "should protect against mass assignment of created_by and updated_by" do
      page = Page.new(:updated_by_id => mock_model("User").id, :created_by_id => mock_model("User").id)
      page.created_by_id.should be_nil
      page.updated_by_id.should be_nil
    end
    
    it "should not allow mass assignment of" do
      @page.should_not allow_mass_assignment_of(:created_by_id => mock_model("User").id, :updated_by_id => mock_model("User").id)
    end
    
    it "should allow mass assignment of" do
      page = Page.new(:title => "foobar", 
             :meta_title => "foobar",  
             :meta_keywords => "foobar", 
             :meta_description => "foobar",
             :layout_id => stub_model(Layout), 
             :filter => stub_model(Filter), 
             :current_state => stub_model(CurrentState))
       page.title.should_not == nil
       page.meta_title.should_not == nil
       page.meta_keywords.should_not == nil
       page.meta_description.should_not == nil
       page.layout_id.should_not == nil
       page.filter.should_not == nil
       page.current_state.should_not == nil
    end
  end
  
  context "before_validation set page filter if it isn't set" do
    it "should set the default filter to html before saving" do
      @page.filter = nil
      @page.save
      @page.filter.name.should == "html"
    end
  end
  
  context "validations" do
    it "should not be valid without a title" do
      @page.title = nil 
      @page.should_not be_valid
    end
    
    it "should not be valid without a unique title" do
      Page.make(:title => @page.title).should_not be_valid
    end
    
    it "should not be valid without a path name" do
      @page.path_name = nil
      @page.should_not be_valid
    end
    
    it "should not be valid without a unique path name" do
      Page.make(:path_name => @page.path_name).should_not be_valid
    end
    
    it "should not be valid without a unique meta_title" do
      Page.make(:meta_title => @page.meta_title).should_not be_valid
    end
    
    it "should not be valid without a filter" do
      @page.filter = nil
      @page.should_not be_valid
    end
    
    it "should not be valid without a current state" do
      @page.stub(:set_filter).and_return(nil)
      @page.current_state = nil
      @page.should_not be_valid
    end
    
    it "should not be valid without a layout" do
      @page.layout = nil
      @page.should_not be_valid
    end
    
    it "should not be valid without a created_by" do
      @page.created_by = nil
      @page.should_not be_valid
    end
    
    it "should not be valid without a updated_by" do
      @page.updated_by = nil
      @page.should_not be_valid
    end
  end
  
  context "associations" do
    it "should embed one current state" do
      @page.should embed_one :current_state
    end
    
    it "should be referenced in layout" do
      @page.should be_referenced_in(:layout)
    end
    
    it "should reference a user with created_by" do
      @page.should be_referenced_in(:created_by).of_type(User).as_inverse_of(:pages_created)
    end
    
    it "should reference a user with updated_by" do
      @page.should be_referenced_in(:updated_by).of_type(User).as_inverse_of(:pages_updated)
    end
  end
  
  context "nested attributes" do
    it "should accept nested attributes for current_state" do
      @page.respond_to?(:build_current_state).should == true
    end
  end
end

















