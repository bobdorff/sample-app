require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Jimmy", email: "thruster@jimmy.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do 
    @user.name = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "b" * 201
    assert_not @user.valid?
  end

  test "email validation should accept valid address" do 
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"                     
    end
  end

  test "email validation rejects invalid addresses" do 
    invalid_addresses = %w[user.example.com User user@foo user@email.com. foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "email validation rejects non-unique emails" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emails are saved as lower case" do
    upper_case_email = 'FOO@bar.COm'
    @user.email = upper_case_email
    @user.save
    assert_equal upper_case_email.downcase, @user.email
  end
end


