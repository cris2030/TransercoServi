require "application_system_test_case"

class ServiciosTest < ApplicationSystemTestCase
  setup do
    @servicio = servicios(:one)
  end

  test "visiting the index" do
    visit servicios_url
    assert_selector "h1", text: "Servicios"
  end

  test "should create servicio" do
    visit servicios_url
    click_on "New servicio"

    fill_in "Fecha", with: @servicio.fecha
    fill_in "Kilometraje", with: @servicio.kilometraje
    fill_in "Nom mecanico", with: @servicio.nom_mecanico
    fill_in "Unidad", with: @servicio.unidad_id
    click_on "Create Servicio"

    assert_text "Servicio was successfully created"
    click_on "Back"
  end

  test "should update Servicio" do
    visit servicio_url(@servicio)
    click_on "Edit this servicio", match: :first

    fill_in "Fecha", with: @servicio.fecha
    fill_in "Kilometraje", with: @servicio.kilometraje
    fill_in "Nom mecanico", with: @servicio.nom_mecanico
    fill_in "Unidad", with: @servicio.unidad_id
    click_on "Update Servicio"

    assert_text "Servicio was successfully updated"
    click_on "Back"
  end

  test "should destroy Servicio" do
    visit servicio_url(@servicio)
    click_on "Destroy this servicio", match: :first

    assert_text "Servicio was successfully destroyed"
  end
end
