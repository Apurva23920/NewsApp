import 'package:News/model/category_model.dart';

List<CategoryModel> getCategories(){

List<CategoryModel> category = new List<CategoryModel>();
CategoryModel categoryModel= new CategoryModel();

categoryModel.categoryName= "Business";
categoryModel.imageUrl="https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "Entertainment";
categoryModel.imageUrl="https://images.unsplash.com/photo-1525869811964-53594bfcb4b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1951&q=80";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "General";
categoryModel.imageUrl="https://images.unsplash.com/photo-1434030216411-0b793f4b4173?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "Health";
categoryModel.imageUrl="https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "Science";
categoryModel.imageUrl="https://images.unsplash.com/photo-1507413245164-6160d8298b31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "Sports";
categoryModel.imageUrl="https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
category.add(categoryModel);

categoryModel= new CategoryModel();

categoryModel.categoryName= "Technology";
categoryModel.imageUrl="https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
category.add(categoryModel);

return category;

}