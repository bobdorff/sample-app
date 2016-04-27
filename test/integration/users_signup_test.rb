require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'it rejects bad signup attempts' do 
    assert_no_difference "User.count" do
      post users_path, user: {name: "", 
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar"
                              }
    end
      assert_template 'users/new'
      assert_select "div#error_explination"
  end
end
