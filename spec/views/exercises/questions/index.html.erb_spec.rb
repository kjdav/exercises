require 'spec_helper'

describe "questions/index" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :exercise_id => 1,
        :content => "MyText",
        :content_html => "MyText",
        :order => 2,
        :credit => "9.99"
      ),
      stub_model(Question,
        :exercise_id => 1,
        :content => "MyText",
        :content_html => "MyText",
        :order => 2,
        :credit => "9.99"
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
