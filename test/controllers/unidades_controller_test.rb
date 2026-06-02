require "test_helper"

class UnidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unidad = unidades(:one)
  end

  test "should get index" do
    get unidades_url
    assert_response :success
  end

  test "should get new" do
    get new_unidad_url
    assert_response :success
  end

  test "should create unidad" do
    assert_difference("Unidad.count") do
      post unidades_url, params: { unidad: { codigo: @unidad.codigo, placa: @unidad.placa, unitID: @unidad.unitID } }
    end

    assert_redirected_to unidad_url(Unidad.last)
  end

  test "should show unidad" do
    get unidad_url(@unidad)
    assert_response :success
  end

  test "should get edit" do
    get edit_unidad_url(@unidad)
    assert_response :success
  end

  test "should update unidad" do
    patch unidad_url(@unidad), params: { unidad: { codigo: @unidad.codigo, placa: @unidad.placa, unitID: @unidad.unitID } }
    assert_redirected_to unidad_url(@unidad)
  end

  test "should destroy unidad" do
    assert_difference("Unidad.count", -1) do
      delete unidad_url(@unidad)
    end

    assert_redirected_to unidades_url
  end
end
