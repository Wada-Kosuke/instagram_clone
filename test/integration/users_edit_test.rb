require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
    @other_user = users(:user2)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    full_name = "Foo Bar"
    user_name = "Foo Baz"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { full_name: full_name,
                                              user_name: user_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal full_name,  @user.full_name
    assert_equal user_name,  @user.user_name
    assert_equal email, @user.email
  end

  test "successful delete" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
