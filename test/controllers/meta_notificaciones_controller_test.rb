require "test_helper"

class MetaNotificacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meta_notificacion = meta_notificaciones(:one)
  end

  test "should get index" do
    get meta_notificaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_meta_notificacion_url
    assert_response :success
  end

  test "should create meta_notificacion" do
    assert_difference("MetaNotificacion.count") do
      post meta_notificaciones_url, params: { meta_notificacion: { estado: @meta_notificacion.estado, meta_id: @meta_notificacion.meta_id, user_id: @meta_notificacion.user_id } }
    end

    assert_redirected_to meta_notificacion_url(MetaNotificacion.last)
  end

  test "should show meta_notificacion" do
    get meta_notificacion_url(@meta_notificacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_meta_notificacion_url(@meta_notificacion)
    assert_response :success
  end

  test "should update meta_notificacion" do
    patch meta_notificacion_url(@meta_notificacion), params: { meta_notificacion: { estado: @meta_notificacion.estado, meta_id: @meta_notificacion.meta_id, user_id: @meta_notificacion.user_id } }
    assert_redirected_to meta_notificacion_url(@meta_notificacion)
  end

  test "should destroy meta_notificacion" do
    assert_difference("MetaNotificacion.count", -1) do
      delete meta_notificacion_url(@meta_notificacion)
    end

    assert_redirected_to meta_notificaciones_url
  end
end
