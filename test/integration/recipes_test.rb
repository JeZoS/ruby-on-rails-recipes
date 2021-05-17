require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(name:'nigga',email:'nigga@nigga.com')
    @recipe = Recipe.create(name:'vegetable sautee',description:'great vegetable sautee, add vegetable and oil',chef:@chef)
    @recipe2 = @chef.recipes.build(name:'chilli paneer',description:'Add chilli and paneer')
    @recipe2.save()
  end

  test 'should get recipes index' do
    get recipes_path
    assert_response :success
  end

  test 'should get recipe listing' do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name,response.body
    assert_match @recipe2.name,response.body
  end

end
