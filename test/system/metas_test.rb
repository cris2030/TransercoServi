require "application_system_test_case"

class MetasTest < ApplicationSystemTestCase
  setup do
    @meta = metas(:one)
  end

  test "visiting the index" do
    visit metas_url
    assert_selector "h1", text: "Metas"
  end

  test "should create meta" do
    visit metas_url
    click_on "New meta"

    fill_in "Color", with: @meta.color
    fill_in "Kilometraje final", with: @meta.kilometraje_final
    fill_in "Kilometraje inicio", with: @meta.kilometraje_inicio
    fill_in "Nivel imp", with: @meta.nivel_imp
    fill_in "Nombre", with: @meta.nombre
    click_on "Create Meta"

    assert_text "Meta was successfully created"
    click_on "Back"
  end

  test "should update Meta" do
    visit meta_url(@meta)
    click_on "Edit this meta", match: :first

    fill_in "Color", with: @meta.color
    fill_in "Kilometraje final", with: @meta.kilometraje_final
    fill_in "Kilometraje inicio", with: @meta.kilometraje_inicio
    fill_in "Nivel imp", with: @meta.nivel_imp
    fill_in "Nombre", with: @meta.nombre
    click_on "Update Meta"

    assert_text "Meta was successfully updated"
    click_on "Back"
  end

  test "should destroy Meta" do
    visit meta_url(@meta)
    click_on "Destroy this meta", match: :first

    assert_text "Meta was successfully destroyed"
  end
end
