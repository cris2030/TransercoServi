require "application_system_test_case"

class MaquinariasTest < ApplicationSystemTestCase
  setup do
    @maquinaria = maquinarias(:one)
  end

  test "visiting the index" do
    visit maquinarias_url
    assert_selector "h1", text: "Maquinarias"
  end

  test "should create maquinaria" do
    visit maquinarias_url
    click_on "New maquinaria"

    fill_in "Codigo", with: @maquinaria.codigo
    fill_in "Nombre", with: @maquinaria.nombre
    fill_in "Numero serie", with: @maquinaria.numero_serie
    click_on "Create Maquinaria"

    assert_text "Maquinaria was successfully created"
    click_on "Back"
  end

  test "should update Maquinaria" do
    visit maquinaria_url(@maquinaria)
    click_on "Edit this maquinaria", match: :first

    fill_in "Codigo", with: @maquinaria.codigo
    fill_in "Nombre", with: @maquinaria.nombre
    fill_in "Numero serie", with: @maquinaria.numero_serie
    click_on "Update Maquinaria"

    assert_text "Maquinaria was successfully updated"
    click_on "Back"
  end

  test "should destroy Maquinaria" do
    visit maquinaria_url(@maquinaria)
    click_on "Destroy this maquinaria", match: :first

    assert_text "Maquinaria was successfully destroyed"
  end
end
