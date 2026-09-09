require "test_helper"

class MaquinariasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maquinaria = maquinarias(:one)
  end

  test "should get index" do
    get maquinarias_url
    assert_response :success
  end

  test "should get new" do
    get new_maquinaria_url
    assert_response :success
  end

  test "should create maquinaria" do
    assert_difference("Maquinaria.count") do
      post maquinarias_url, params: { maquinaria: { codigo: @maquinaria.codigo, nombre: @maquinaria.nombre, numero_serie: @maquinaria.numero_serie } }
    end

    assert_redirected_to maquinaria_url(Maquinaria.last)
  end

  test "should show maquinaria" do
    get maquinaria_url(@maquinaria)
    assert_response :success
  end

  test "should get edit" do
    get edit_maquinaria_url(@maquinaria)
    assert_response :success
  end

  test "should update maquinaria" do
    patch maquinaria_url(@maquinaria), params: { maquinaria: { codigo: @maquinaria.codigo, nombre: @maquinaria.nombre, numero_serie: @maquinaria.numero_serie } }
    assert_redirected_to maquinaria_url(@maquinaria)
  end

  test "should destroy maquinaria" do
    assert_difference("Maquinaria.count", -1) do
      delete maquinaria_url(@maquinaria)
    end

    assert_redirected_to maquinarias_url
  end
end
