require 'test_helper'

class CybercontrolsControllerTest < ActionController::TestCase
  setup do
    @cybercontrol = cybercontrols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cybercontrols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cybercontrol" do
    assert_difference('Cybercontrol.count') do
      post :create, :cybercontrol => @cybercontrol.attributes
    end

    assert_redirected_to cybercontrol_path(assigns(:cybercontrol))
  end

  test "should show cybercontrol" do
    get :show, :id => @cybercontrol.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cybercontrol.to_param
    assert_response :success
  end

  test "should update cybercontrol" do
    put :update, :id => @cybercontrol.to_param, :cybercontrol => @cybercontrol.attributes
    assert_redirected_to cybercontrol_path(assigns(:cybercontrol))
  end

  test "should destroy cybercontrol" do
    assert_difference('Cybercontrol.count', -1) do
      delete :destroy, :id => @cybercontrol.to_param
    end

    assert_redirected_to cybercontrols_path
  end
end
