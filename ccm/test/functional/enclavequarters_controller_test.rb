require 'test_helper'

class EnclavequartersControllerTest < ActionController::TestCase
  setup do
    @enclavequarter = enclavequarters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enclavequarters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enclavequarter" do
    assert_difference('Enclavequarter.count') do
      post :create, :enclavequarter => @enclavequarter.attributes
    end

    assert_redirected_to enclavequarter_path(assigns(:enclavequarter))
  end

  test "should show enclavequarter" do
    get :show, :id => @enclavequarter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @enclavequarter.to_param
    assert_response :success
  end

  test "should update enclavequarter" do
    put :update, :id => @enclavequarter.to_param, :enclavequarter => @enclavequarter.attributes
    assert_redirected_to enclavequarter_path(assigns(:enclavequarter))
  end

  test "should destroy enclavequarter" do
    assert_difference('Enclavequarter.count', -1) do
      delete :destroy, :id => @enclavequarter.to_param
    end

    assert_redirected_to enclavequarters_path
  end
end
