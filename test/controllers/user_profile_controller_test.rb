# frozen_string_literal: true

require "test_helper"

class UserProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get user_profile_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_profile_update_url
    assert_response :success
  end
end
