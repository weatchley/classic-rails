require 'test_helper'

class EnclavesControllerTest < ActionController::TestCase
  setup do
    @enclafe = enclaves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enclaves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enclafe" do
    assert_difference('Enclave.count') do
      post :create, :enclafe => @enclafe.attributes
    end

    assert_redirected_to enclafe_path(assigns(:enclafe))
  end

  test "should show enclafe" do
    get :show, :id => @enclafe.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @enclafe.to_param
    assert_response :success
  end

  test "should update enclafe" do
    put :update, :id => @enclafe.to_param, :enclafe => @enclafe.attributes
    assert_redirected_to enclafe_path(assigns(:enclafe))
  end

  test "should destroy enclafe" do
    assert_difference('Enclave.count', -1) do
      delete :destroy, :id => @enclafe.to_param
    end

    assert_redirected_to enclaves_path
  end
end
