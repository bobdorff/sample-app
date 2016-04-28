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

  test 'it accepts a valid signup and redirects correctly' do
    get signup_path
    assert_difference "User.count", 1 do 
      post_via_redirect users_path, user: {name: "Bob", 
                              email: "user@valid.com",
                              password: "foooooo",
                              password_confirmation: "foooooo"
                              }
    end
    assert_template 'users/show'
    assert_select "div.alert"
    assert is_logged_in?
  end
end
