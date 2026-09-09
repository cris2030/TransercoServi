require "application_system_test_case"

class ServicioMaquinariasTest < ApplicationSystemTestCase
  setup do
    @servicio_maquinaria = servicio_maquinarias(:one)
  end

  test "visiting the index" do
    visit servicio_maquinarias_url
    assert_selector "h1", text: "Servicio maquinarias"
  end

  test "should create servicio maquinaria" do
    visit servicio_maquinarias_url
    click_on "New servicio maquinaria"

    fill_in "Fecha", with: @servicio_maquinaria.fecha
    fill_in "Hora", with: @servicio_maquinaria.hora
    fill_in "Maquinaria", with: @servicio_maquinaria.maquinaria_id
    click_on "Create Servicio maquinaria"

    assert_text "Servicio maquinaria was successfully created"
    click_on "Back"
  end

  test "should update Servicio maquinaria" do
    visit servicio_maquinaria_url(@servicio_maquinaria)
    click_on "Edit this servicio maquinaria", match: :first

    fill_in "Fecha", with: @servicio_maquinaria.fecha
    fill_in "Hora", with: @servicio_maquinaria.hora.to_s
    fill_in "Maquinaria", with: @servicio_maquinaria.maquinaria_id
    click_on "Update Servicio maquinaria"

    assert_text "Servicio maquinaria was successfully updated"
    click_on "Back"
  end

  test "should destroy Servicio maquinaria" do
    visit servicio_maquinaria_url(@servicio_maquinaria)
    click_on "Destroy this servicio maquinaria", match: :first

    assert_text "Servicio maquinaria was successfully destroyed"
  end
end
