require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    test "error data won't create user" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, params:{
                user:{
                    name: "",
                    email: "user@invalid",
                    password:"foo",
                    password_confirmation: "bar"
                }
            }
        end
        follow_redirect!
        assert_template 'users/new'
        assert_select 'div#<CSS id for error explanation>'
        assert_select 'div.<CSS class for field with error>'
        assert_not flash.FILL_IN
    end
end
