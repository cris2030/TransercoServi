require "test_helper"

class AsignacionMetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asignacion_meta = asignacion_metas(:one)
  end

  test "should get index" do
    get asignacion_metas_url
    assert_response :success
  end

  test "should get new" do
    get new_asignacion_meta_url
    assert_response :success
  end

  test "should create asignacion_meta" do
    assert_difference("AsignacionMeta.count") do
      post asignacion_metas_url, params: { asignacion_meta: { meta_id: @asignacion_meta.meta_id, unidad_id: @asignacion_meta.unidad_id } }
    end

    assert_redirected_to asignacion_meta_url(AsignacionMeta.last)
  end

  test "should show asignacion_meta" do
    get asignacion_meta_url(@asignacion_meta)
    assert_response :success
  end

  test "should get edit" do
    get edit_asignacion_meta_url(@asignacion_meta)
    assert_response :success
  end

  test "should update asignacion_meta" do
    patch asignacion_meta_url(@asignacion_meta), params: { asignacion_meta: { meta_id: @asignacion_meta.meta_id, unidad_id: @asignacion_meta.unidad_id } }
    assert_redirected_to asignacion_meta_url(@asignacion_meta)
  end

  test "should destroy asignacion_meta" do
    assert_difference("AsignacionMeta.count", -1) do
      delete asignacion_meta_url(@asignacion_meta)
    end

    assert_redirected_to asignacion_metas_url
  end
end
