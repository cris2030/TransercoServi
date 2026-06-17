require "application_system_test_case"

class MetaNotificacionesTest < ApplicationSystemTestCase
  setup do
    @meta_notificacion = meta_notificaciones(:one)
  end

  test "visiting the index" do
    visit meta_notificaciones_url
    assert_selector "h1", text: "Meta notificacions"
  end

  test "should create meta notificacion" do
    visit meta_notificaciones_url
    click_on "New meta notificacion"

    fill_in "Estado", with: @meta_notificacion.estado
    fill_in "Meta", with: @meta_notificacion.meta_id
    fill_in "User", with: @meta_notificacion.user_id
    click_on "Create Meta notificacion"

    assert_text "Meta notificacion was successfully created"
    click_on "Back"
  end

  test "should update Meta notificacion" do
    visit meta_notificacion_url(@meta_notificacion)
    click_on "Edit this meta notificacion", match: :first

    fill_in "Estado", with: @meta_notificacion.estado
    fill_in "Meta", with: @meta_notificacion.meta_id
    fill_in "User", with: @meta_notificacion.user_id
    click_on "Update Meta notificacion"

    assert_text "Meta notificacion was successfully updated"
    click_on "Back"
  end

  test "should destroy Meta notificacion" do
    visit meta_notificacion_url(@meta_notificacion)
    click_on "Destroy this meta notificacion", match: :first

    assert_text "Meta notificacion was successfully destroyed"
  end
end
