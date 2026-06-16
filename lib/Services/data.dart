
import '../Model/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category = [];

  CategoryModel categoryModel = new CategoryModel();

  categoryModel.CategoryName = "Business";
  categoryModel.Image = "images/business.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.CategoryName = "Health";
  categoryModel.Image = "images/health.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.CategoryName = "General";
  categoryModel.Image = "images/general.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.CategoryName = "entertainment";
  categoryModel.Image = "images/entertainment.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.CategoryName = "sport";
  categoryModel.Image = "images/sport.jpeg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

return category;

}