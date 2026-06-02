require "application_system_test_case"

class AsignacionMetasTest < ApplicationSystemTestCase
  setup do
    @asignacion_meta = asignacion_metas(:one)
  end

  test "visiting the index" do
    visit asignacion_metas_url
    assert_selector "h1", text: "Asignacion metas"
  end

  test "should create asignacion meta" do
    visit asignacion_metas_url
    click_on "New asignacion meta"

    fill_in "Meta", with: @asignacion_meta.meta_id
    fill_in "Unidad", with: @asignacion_meta.unidad_id
    click_on "Create Asignacion meta"

    assert_text "Asignacion meta was successfully created"
    click_on "Back"
  end

  test "should update Asignacion meta" do
    visit asignacion_meta_url(@asignacion_meta)
    click_on "Edit this asignacion meta", match: :first

    fill_in "Meta", with: @asignacion_meta.meta_id
    fill_in "Unidad", with: @asignacion_meta.unidad_id
    click_on "Update Asignacion meta"

    assert_text "Asignacion meta was successfully updated"
    click_on "Back"
  end

  test "should destroy Asignacion meta" do
    visit asignacion_meta_url(@asignacion_meta)
    click_on "Destroy this asignacion meta", match: :first

    assert_text "Asignacion meta was successfully destroyed"
  end
end
