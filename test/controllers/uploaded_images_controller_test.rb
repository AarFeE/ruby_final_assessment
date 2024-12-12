require "test_helper"

class UploadedImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uploaded_image = uploaded_images(:one)
  end

  test "should get index" do
    get uploaded_images_url
    assert_response :success
  end

  test "should get new" do
    get new_uploaded_image_url
    assert_response :success
  end

  test "should create uploaded_image" do
    assert_difference("UploadedImage.count") do
      post uploaded_images_url, params: { uploaded_image: { title: @uploaded_image.title } }
    end

    assert_redirected_to uploaded_image_url(UploadedImage.last)
  end

  test "should show uploaded_image" do
    get uploaded_image_url(@uploaded_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_uploaded_image_url(@uploaded_image)
    assert_response :success
  end

  test "should update uploaded_image" do
    patch uploaded_image_url(@uploaded_image), params: { uploaded_image: { title: @uploaded_image.title } }
    assert_redirected_to uploaded_image_url(@uploaded_image)
  end

  test "should destroy uploaded_image" do
    assert_difference("UploadedImage.count", -1) do
      delete uploaded_image_url(@uploaded_image)
    end

    assert_redirected_to uploaded_images_url
  end
end
