require 'test_helper'

class ColloquiesControllerTest < ActionController::TestCase
  setup do
    @colloquy = colloquies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colloquies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colloquy" do
    assert_difference('Colloquy.count') do
      post :create, colloquy: { close: @colloquy.close, description: @colloquy.description, name: @colloquy.name, open: @colloquy.open, organization: @colloquy.organization, seats: @colloquy.seats }
    end

    assert_redirected_to colloquy_path(assigns(:colloquy))
  end

  test "should show colloquy" do
    get :show, id: @colloquy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @colloquy
    assert_response :success
  end

  test "should update colloquy" do
    put :update, id: @colloquy, colloquy: { close: @colloquy.close, description: @colloquy.description, name: @colloquy.name, open: @colloquy.open, organization: @colloquy.organization, seats: @colloquy.seats }
    assert_redirected_to colloquy_path(assigns(:colloquy))
  end

  test "should destroy colloquy" do
    assert_difference('Colloquy.count', -1) do
      delete :destroy, id: @colloquy
    end

    assert_redirected_to colloquies_path
  end
end
