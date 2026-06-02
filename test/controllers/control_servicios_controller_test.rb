require "test_helper"

class ControlServiciosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get control_servicios_index_url
    assert_response :success
  end

  test "should get actualizar" do
    get control_servicios_actualizar_url
    assert_response :success
  end
end
