require "test_helper"

class MetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meta = metas(:one)
  end

  test "should get index" do
    get metas_url
    assert_response :success
  end

  test "should get new" do
    get new_meta_url
    assert_response :success
  end

  test "should create meta" do
    assert_difference("Meta.count") do
      post metas_url, params: { meta: { color: @meta.color, kilometraje_final: @meta.kilometraje_final, kilometraje_inicio: @meta.kilometraje_inicio, nivel_imp: @meta.nivel_imp, nombre: @meta.nombre } }
    end

    assert_redirected_to meta_url(Meta.last)
  end

  test "should show meta" do
    get meta_url(@meta)
    assert_response :success
  end

  test "should get edit" do
    get edit_meta_url(@meta)
    assert_response :success
  end

  test "should update meta" do
    patch meta_url(@meta), params: { meta: { color: @meta.color, kilometraje_final: @meta.kilometraje_final, kilometraje_inicio: @meta.kilometraje_inicio, nivel_imp: @meta.nivel_imp, nombre: @meta.nombre } }
    assert_redirected_to meta_url(@meta)
  end

  test "should destroy meta" do
    assert_difference("Meta.count", -1) do
      delete meta_url(@meta)
    end

    assert_redirected_to metas_url
  end
end
