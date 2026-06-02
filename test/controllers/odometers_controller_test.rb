require "test_helper"

class OdometersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get odometers_index_url
    assert_response :success
  end
end
