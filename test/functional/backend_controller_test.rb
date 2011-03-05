require 'test_helper'

class BackendControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get subjects" do
    get :subjects
    assert_response :success
  end

end
