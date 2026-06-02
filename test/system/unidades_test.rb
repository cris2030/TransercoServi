require "application_system_test_case"

class UnidadesTest < ApplicationSystemTestCase
  setup do
    @unidad = unidades(:one)
  end

  test "visiting the index" do
    visit unidades_url
    assert_selector "h1", text: "Unidades"
  end

  test "should create unidad" do
    visit unidades_url
    click_on "New unidad"

    fill_in "Codigo", with: @unidad.codigo
    fill_in "Placa", with: @unidad.placa
    fill_in "Unitid", with: @unidad.unitID
    click_on "Create Unidad"

    assert_text "Unidad was successfully created"
    click_on "Back"
  end

  test "should update Unidad" do
    visit unidad_url(@unidad)
    click_on "Edit this unidad", match: :first

    fill_in "Codigo", with: @unidad.codigo
    fill_in "Placa", with: @unidad.placa
    fill_in "Unitid", with: @unidad.unitID
    click_on "Update Unidad"

    assert_text "Unidad was successfully updated"
    click_on "Back"
  end

  test "should destroy Unidad" do
    visit unidad_url(@unidad)
    click_on "Destroy this unidad", match: :first

    assert_text "Unidad was successfully destroyed"
  end
end
