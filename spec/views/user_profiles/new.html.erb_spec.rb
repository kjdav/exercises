require 'spec_helper'

describe "user_profiles/new" do
  before(:each) do
    assign(:user_profile, stub_model(UserProfile,
      :user_id => 1,
      :group_member_email => false,
      :collaborator_request_email => false,
      :announcement_email => false,
      :auto_author_subscribe => false
    ).as_new_record)
  end

  it "renders new user_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_profiles_path, "post" do
      assert_select "input#user_profile_user_id[name=?]", "user_profile[user_id]"
      assert_select "input#user_profile_group_member_email[name=?]", "user_profile[group_member_email]"
      assert_select "input#user_profile_collaborator_request_email[name=?]", "user_profile[collaborator_request_email]"
      assert_select "input#user_profile_announcement_email[name=?]", "user_profile[announcement_email]"
      assert_select "input#user_profile_auto_author_subscribe[name=?]", "user_profile[auto_author_subscribe]"
    end
  end
end
