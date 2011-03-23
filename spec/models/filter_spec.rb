# spec for Filter
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe Filter do   
  before(:each) do
    @filter = Filter.make
  end
  
  context "validations" do
    it "should create a valid Filter" do
      @filter.should be_valid
    end
    
    it "should not be valid without a filter name" do
      @filter.name = nil
      @filter.should_not be_valid
    end
  end
  
  context "finder methods" do
    before(:each) do
      Filter.filters << Filter.new(:name => "foobar")  
    end
    context "Filter#all" do
      it "should find return all of the filters" do
        Filter.all.count == 4
      end
    
      it "should return an array of Filter objects" do
        Filter.all.first.class == "Filter"
      end
    end
  
    context "Filter#find" do
      it "should return the Filter object" do
        Filter.find("foobar").class == "Filter"
      end
    
      it "should have the name of foobar for the returned filter" do
        Filter.find("foobar").name == "foobar"
      end
    end
  
    context "Filter#find_by_name" do
      it "should return the Filter object" do
        Filter.find_by_name("foobar").class == "Filter"
      end
    
      it "should have the name of foobar for the returned filter" do
        Filter.find_by_name("foobar").name == "foobar"
      end
    end
  end
end