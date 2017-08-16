require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should be valid" do
      assert @user.valid?
  end

  test "name should be present" do
      @user.name=""
      assert_not @user.valid?
  end

  test "email should be present" do
      @user.email="   "
      assert_not @user.valid?
  end

  test "name should not be too long" do
      @user.name = "a"*51;
      assert_not @user.valid?
  end

  test "email should not be too long" do
      @user.email = "a"*244 +"@example.com"
      assert_not @user.valid?
  end

  test "email validation should accept valid address" do
      valid_address = %w[user@example,com User@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_address.each do |valid_address|
          @user.email = valid_address
          assert @user.valid?,"#{valid_address.inspect} should be valid"
      end
  end

  test "email addresses should be unique" do
      duplicate_user = @user.save
      assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
        mixed_case_email = "Foo@ExAMPle.com"
        @user.email = mixed_case_email
        @user.saved
        assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " "*6
      assert_not @user.valid?
  end

  test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a"*5
      assert_not @user.valid?
  end

  def setup
      @user = User.new(name:"Example User", email:"user@example.com", password:"foobar", password_confirmation:"foobar")
  end
end
