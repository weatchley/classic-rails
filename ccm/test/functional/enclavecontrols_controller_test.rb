require 'test_helper'

class EnclavecontrolsControllerTest < ActionController::TestCase
  setup do
    @enclavecontrol = enclavecontrols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enclavecontrols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enclavecontrol" do
    assert_difference('Enclavecontrol.count') do
      post :create, :enclavecontrol => @enclavecontrol.attributes
    end

    assert_redirected_to enclavecontrol_path(assigns(:enclavecontrol))
  end

  test "should show enclavecontrol" do
    get :show, :id => @enclavecontrol.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @enclavecontrol.to_param
    assert_response :success
  end

  test "should update enclavecontrol" do
    put :update, :id => @enclavecontrol.to_param, :enclavecontrol => @enclavecontrol.attributes
    assert_redirected_to enclavecontrol_path(assigns(:enclavecontrol))
  end

  test "should destroy enclavecontrol" do
    assert_difference('Enclavecontrol.count', -1) do
      delete :destroy, :id => @enclavecontrol.to_param
    end

    assert_redirected_to enclavecontrols_path
  end
end
