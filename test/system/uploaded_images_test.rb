require "application_system_test_case"

class UploadedImagesTest < ApplicationSystemTestCase
  setup do
    @uploaded_image = uploaded_images(:one)
  end

  test "visiting the index" do
    visit uploaded_images_url
    assert_selector "h1", text: "Uploaded images"
  end

  test "should create uploaded image" do
    visit uploaded_images_url
    click_on "New uploaded image"

    fill_in "Title", with: @uploaded_image.title
    click_on "Create Uploaded image"

    assert_text "Uploaded image was successfully created"
    click_on "Back"
  end

  test "should update Uploaded image" do
    visit uploaded_image_url(@uploaded_image)
    click_on "Edit this uploaded image", match: :first

    fill_in "Title", with: @uploaded_image.title
    click_on "Update Uploaded image"

    assert_text "Uploaded image was successfully updated"
    click_on "Back"
  end

  test "should destroy Uploaded image" do
    visit uploaded_image_url(@uploaded_image)
    click_on "Destroy this uploaded image", match: :first

    assert_text "Uploaded image was successfully destroyed"
  end
end
