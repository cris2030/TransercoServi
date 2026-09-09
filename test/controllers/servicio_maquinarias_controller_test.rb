require "test_helper"

class ServicioMaquinariasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @servicio_maquinaria = servicio_maquinarias(:one)
  end

  test "should get index" do
    get servicio_maquinarias_url
    assert_response :success
  end

  test "should get new" do
    get new_servicio_maquinaria_url
    assert_response :success
  end

  test "should create servicio_maquinaria" do
    assert_difference("ServicioMaquinaria.count") do
      post servicio_maquinarias_url, params: { servicio_maquinaria: { fecha: @servicio_maquinaria.fecha, hora: @servicio_maquinaria.hora, maquinaria_id: @servicio_maquinaria.maquinaria_id } }
    end

    assert_redirected_to servicio_maquinaria_url(ServicioMaquinaria.last)
  end

  test "should show servicio_maquinaria" do
    get servicio_maquinaria_url(@servicio_maquinaria)
    assert_response :success
  end

  test "should get edit" do
    get edit_servicio_maquinaria_url(@servicio_maquinaria)
    assert_response :success
  end

  test "should update servicio_maquinaria" do
    patch servicio_maquinaria_url(@servicio_maquinaria), params: { servicio_maquinaria: { fecha: @servicio_maquinaria.fecha, hora: @servicio_maquinaria.hora, maquinaria_id: @servicio_maquinaria.maquinaria_id } }
    assert_redirected_to servicio_maquinaria_url(@servicio_maquinaria)
  end

  test "should destroy servicio_maquinaria" do
    assert_difference("ServicioMaquinaria.count", -1) do
      delete servicio_maquinaria_url(@servicio_maquinaria)
    end

    assert_redirected_to servicio_maquinarias_url
  end
end
