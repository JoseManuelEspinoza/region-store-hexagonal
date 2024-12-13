require "test_helper"

class RegionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @region = regions(:peru)
  end

  test "debería obtener el índice" do
    get regions_url
    assert_response :success
  end

  test "debería obtener nuevo" do
    get new_region_url
    assert_response :success
  end

  test "crear una region" do
    assert_difference("Region.count") do
      post regions_url, params: { region: { name: @region.name } }
    end

    assert_redirected_to regions_url
  end


  test "should get edit" do
    get edit_region_url(@region)
    assert_response :success
  end

  test "actualizar datos de una region" do
    patch region_url(@region), params: { region: { name: @region.name } }
    assert_redirected_to regions_url(@region)
  end

  test "eliminar una region" do
    assert_difference("Region.count", -1) do
      delete region_url(@region)
    end

    assert_redirected_to regions_url
  end
end
