require 'test_helper'

class ConfigvaluesControllerTest < ActionController::TestCase
  setup do
    @configvalue = configvalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:configvalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create configvalue" do
    assert_difference('Configvalue.count') do
      post :create, :configvalue => @configvalue.attributes
    end

    assert_redirected_to configvalue_path(assigns(:configvalue))
  end

  test "should show configvalue" do
    get :show, :id => @configvalue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @configvalue.to_param
    assert_response :success
  end

  test "should update configvalue" do
    put :update, :id => @configvalue.to_param, :configvalue => @configvalue.attributes
    assert_redirected_to configvalue_path(assigns(:configvalue))
  end

  test "should destroy configvalue" do
    assert_difference('Configvalue.count', -1) do
      delete :destroy, :id => @configvalue.to_param
    end

    assert_redirected_to configvalues_path
  end
end
