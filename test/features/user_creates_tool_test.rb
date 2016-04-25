require "test_helper"

class UserFeaturesTest < ActionDispatch::IntegrationTest

  # test "user can create a tool" do
  #   #a user will go to the new form
  #   visit new_tool_path
  #   #they will enter data in each of the fields
  #   fill_in "Name", with: "Screwdriver"
  #   fill_in "Price", with: "10.99"
  #   fill_in "Quantity", with: "10"
  #   #they will submit that data
  #   click_button "Create Tool"
  #   #then they will be taken to that tools show page
  #   assert_equal tool_path(Tool.last.id), current_path
  #   #and expect to see that data that was submitted
  #   within(".tool_info") do
  #     assert page.has_content?("Screwdriver")
  #     assert page.has_content?("10.99")
  #     assert page.has_content?("10")
  #   end
  # end

  test "user can view index and tool show pages that belong to itself" do
    user = User.create(name:"Gangsta Joe",
                   username: "lil J",
                   password: "password",
      password_confirmation: "password")

      user.tools.create(name: "axe", price: 3, quantity: 3)
      Tool.create(name: "hammer", price: 10, quantity: 3)

    # ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit '/login'
    fill_in "username", with: "lil J"
    fill_in "password", with: "password"
    click_on "click to login"
    assert_equal "/users/#{user.id}", current_path
    click_link "Your Tools"
    assert page.has_content?("axe")
    refute page.has_content?("hammer")
    click_link "axe"
    assert page.has_content?("axe - 3")
  end

  test "user can only update self" do
    user = User.create(name:"Gangsta Joe",
                 username: "lil J",
                 password: "password",
    password_confirmation: "password")
    User.create(name: "name",
            username: "named",
            password: "pass",
             password_confirmation: "pass")

    user.tools.create(name: "axe", price: 3, quantity: 3)
    Tool.create(name: "hammer", price: 10, quantity: 3)
    visit '/login'
    fill_in "username", with: "lil J"
    fill_in "password", with: "password"
    click_on "click to login"
    click_on "Edit"
    fill_in "name", with: "tester"
    fill_in "username", with: "lil J"
    fill_in "password", with: "password"
    fill_in "password confirmation", with: "password"
    click_on "Update User"
    assert page.has_content?("tester")
    visit "/users"
    click_on "name"
    assert_equal "/login", current_path

  end

  # test "logged in user can see category page with tools" do
  #   user = User.create(name:"Gangsta Joe",
  #                username: "lil J",
  #                password: "password",
  #   password_confirmation: "password")
  #
  #   category = Category.create(name: "home")
  #   user.tools.create(name: "axe", price: 3, quantity: 3, category_id: category )
  #
  #   visit '/login'
  #   fill_in "username", with: "lil J"
  #   fill_in "password", with: "password"
  #   click_on "click to login"
  #
  #   click_on "categories"
  #   assert page.has_content?("home - axe")
  #   visit "/categories/edit"
  #   assert page.has_content?("404")
  # end

  test "admin can crud tools" do
    admin = User.create(name:"adminname",
                 username: "username",
                 password: "password",
    password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_tools_path
    save_and_open_page
  end


# can create, update, read, and delete tools. When creating a tool they must assign it to a default user.

end
